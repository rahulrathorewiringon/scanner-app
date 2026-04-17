package com.rathore.stockanalysis.instrument.repository.impl;

import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import com.rathore.stockanalysis.instrument.dto.*;
import com.rathore.stockanalysis.instrument.repository.InstrumentQueryRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class InstrumentQueryRepositoryImpl implements InstrumentQueryRepository {

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;

    public InstrumentQueryRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate,
                                         ExchangeSchemaRegistry exchangeSchemaRegistry) {
        this.jdbcTemplate = jdbcTemplate;
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
    }

    @Override
    public InstrumentSearchResponseDto search(InstrumentSearchRequestDto request) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(request.exchangeCode());
        String sortField = "symbol";
        String sortDirection = "asc";
        if (request.sort() != null && !request.sort().isEmpty()) {
            sortField = request.sort().get(0).field();
            sortDirection = request.sort().get(0).direction();
        }
        String orderBy = switch (sortField == null ? "symbol" : sortField) {
            case "instrumentId", "instrument_id" -> "snap.instrument_id";
            case "latestTradeDate", "latest_trade_date" -> "snap.latest_trade_date_day";
            case "trendState", "trend_state" -> "snap.trend_state_day";
            case "latestCloseDay", "latest_close_day" -> "snap.latest_close_day";
            case "updatedAt", "updated_at" -> "snap.updated_at";
            default -> "snap.symbol";
        } + ("desc".equalsIgnoreCase(sortDirection) ? " DESC" : " ASC");

        String where = """
                WHERE snap.exchange_code = :exchangeCode
                  AND snap.chart_data_exists = true
                  AND (:tradeDate IS NULL OR CAST(snap.latest_trade_date_day AS text) = :tradeDate)
                  AND (:trendFilter IS NULL OR :trendFilter = 'ALL' OR snap.trend_state_day = :trendFilter)
                  AND (:sector IS NULL OR COALESCE(eq.sector, 'UNKNOWN') = :sector)
                  AND (:symbolQuery IS NULL OR snap.symbol ILIKE '%' || :symbolQuery || '%' OR COALESCE(snap.trading_symbol, '') ILIKE '%' || :symbolQuery || '%')
                  AND (:candleType IS NULL OR snap.current_candle_pattern_day = :candleType)
                  AND (:pivotType IS NULL OR snap.latest_pivot_type_day = :pivotType)
                  AND (:smaStructure IS NULL OR snap.sma_structure_day = :smaStructure)
                """;

        if (request.timeframeFilter() != null && !request.timeframeFilter().isEmpty()) {
            for (String tf : request.timeframeFilter()) {
                where += " AND snap.chart_timeframes_available_json::text LIKE '%" + sanitizeTimeframe(tf) + "%' ";
            }
        }

        String from = """
                FROM app_ui.instrument_latest_snapshot snap
                LEFT JOIN %s.instrument_master_equity eq
                  ON eq.instrument_id = snap.instrument_id
                """.formatted(schema.masterSchema());

        String countSql = "SELECT COUNT(*) " + from + where;
        MapSqlParameterSource params = params(request, schema.exchangeCode());
        Long total = jdbcTemplate.queryForObject(countSql, params, Long.class);
        if (total == null) total = 0L;

        String dataSql = """
                SELECT
                    snap.instrument_id,
                    snap.symbol,
                    snap.trading_symbol,
                    snap.instrument_type,
                    COALESCE(eq.sector, 'UNKNOWN') AS sector,
                    snap.exchange_code,
                    CAST(snap.latest_trade_date_day AS text) AS latest_trade_date,
                    snap.chart_data_exists,
                    snap.chart_timeframes_available_json::text AS chart_timeframes_available,
                    snap.bootstrap_status,
                    snap.chart_data_status,
                    snap.trend_state_day,
                    snap.current_candle_pattern_day,
                    snap.latest_pivot_type_day,
                    snap.latest_trend_pivot_type_day,
                    snap.sma_structure_day,
                    CAST(snap.updated_at AS text) AS updated_at
                """ + from + where + " ORDER BY " + orderBy + " LIMIT :limit OFFSET :offset";

        params.addValue("limit", request.pageSize()).addValue("offset", request.pageIndex() * request.pageSize());
        List<InstrumentRowDto> rows = jdbcTemplate.query(dataSql, params, (rs, rowNum) -> mapInstrumentRow(rs));
        return new InstrumentSearchResponseDto(rows, total, request.pageIndex(), request.pageSize());
    }

    @Override
    public InstrumentSummaryDto fetchSummary(String exchangeCode, long instrumentId) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String identitySql = """
                SELECT
                    snap.instrument_id,
                    snap.symbol,
                    snap.trading_symbol,
                    snap.instrument_type,
                    NULL::text AS asset_class,
                    eq.sector,
                    eq.industry,
                    snap.exchange_code,
                    snap.chart_data_exists,
                    snap.bootstrap_status,
                    snap.chart_data_status,
                    CAST(snap.chart_from_date AS text) AS chart_from_date,
                    CAST(snap.chart_to_date AS text) AS chart_to_date,
                    snap.chart_timeframes_available_json::text AS chart_timeframes_available,
                    CAST(snap.reconcile_watermark_date AS text) AS reconcile_watermark_date,
                    CAST(snap.bootstrap_completed_through_date AS text) AS bootstrap_completed_through_date,
                    CAST(snap.last_bootstrap_completed_at AS text) AS last_bootstrap_completed_at,
                    CAST(snap.last_reconcile_completed_at AS text) AS last_reconcile_completed_at,
                    snap.trend_state_day,
                    snap.current_candle_pattern_day,
                    snap.latest_pivot_type_day,
                    snap.latest_trend_pivot_type_day,
                    snap.sma_structure_week,
                    snap.sma_structure_day,
                    snap.sma_structure_hour
                FROM app_ui.instrument_latest_snapshot snap
                LEFT JOIN %s.instrument_master_equity eq
                  ON eq.instrument_id = snap.instrument_id
                WHERE snap.exchange_code = :exchangeCode
                  AND snap.instrument_id = :instrumentId
                """.formatted(schema.masterSchema());

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("exchangeCode", schema.exchangeCode())
                .addValue("instrumentId", instrumentId);

        InstrumentSummaryDto summary = jdbcTemplate.query(identitySql, params, rs -> {
            if (!rs.next()) {
                return null;
            }
            InstrumentSummaryDto.Identity identity = new InstrumentSummaryDto.Identity(
                    rs.getLong("instrument_id"),
                    rs.getString("symbol"),
                    rs.getString("trading_symbol"),
                    rs.getString("instrument_type"),
                    rs.getString("asset_class"),
                    rs.getString("sector"),
                    rs.getString("industry"),
                    rs.getString("exchange_code")
            );
            InstrumentSummaryDto.DataAvailability availability = new InstrumentSummaryDto.DataAvailability(
                    rs.getBoolean("chart_data_exists"),
                    rs.getString("bootstrap_status"),
                    rs.getString("chart_data_status"),
                    rs.getString("chart_from_date"),
                    rs.getString("chart_to_date"),
                    parseJsonArrayText(rs.getString("chart_timeframes_available")),
                    rs.getString("reconcile_watermark_date"),
                    rs.getString("bootstrap_completed_through_date"),
                    rs.getString("last_bootstrap_completed_at"),
                    rs.getString("last_reconcile_completed_at")
            );
            InstrumentSummaryDto.Trend trend = new InstrumentSummaryDto.Trend(
                    rs.getString("trend_state_day"),
                    "core_app_nse + market_nse",
                    null,
                    "day"
            );
            InstrumentSummaryDto.SmaStructure sma = new InstrumentSummaryDto.SmaStructure(
                    rs.getString("sma_structure_week"),
                    rs.getString("sma_structure_day"),
                    rs.getString("sma_structure_hour"),
                    null,
                    null
            );
            InstrumentSummaryDto.Pivots pivots = fetchPivots(instrumentId);
            InstrumentSummaryDto.LatestPrices prices = new InstrumentSummaryDto.LatestPrices(
                    fetchLatestPrice(schema.marketSchema(), instrumentId, "week"),
                    fetchLatestPrice(schema.marketSchema(), instrumentId, "day"),
                    fetchLatestPrice(schema.marketSchema(), instrumentId, "hour")
            );
            InstrumentSummaryDto.CandleAnalysis candle = fetchCandleAnalysis(schema.marketSchema(), instrumentId);
            return new InstrumentSummaryDto(identity, availability, prices, trend, pivots, sma, candle);
        });

        if (summary == null) {
            throw new IllegalArgumentException("Instrument not found: " + instrumentId);
        }
        return summary;
    }

    private InstrumentSummaryDto.Pivots fetchPivots(long instrumentId) {
        String sql = """
                SELECT timeframe, CAST(pivot_ts AS text) AS pivot_ts, tf_id, pivot_type, pivot_price, trend_pivot_type
                FROM app_ui.instrument_pivot_sequence_latest
                WHERE instrument_id = :instrumentId
                ORDER BY timeframe, rn ASC
                """;
        List<PivotEventDto> events = jdbcTemplate.query(sql,
                new MapSqlParameterSource("instrumentId", instrumentId),
                (rs, rowNum) -> new PivotEventDto(
                        rs.getString("timeframe"),
                        rs.getString("pivot_ts"),
                        rs.getLong("tf_id"),
                        rs.getString("pivot_type"),
                        true,
                        rs.getObject("pivot_price") != null ? rs.getDouble("pivot_price") : null,
                        rs.getString("trend_pivot_type")
                ));
        String latestPivotType = events.isEmpty() ? null : events.getFirst().pivotType();
        String previousPivotType = events.size() > 1 ? events.get(1).pivotType() : null;
        String latestTrendPivotType = events.isEmpty() ? null : events.getFirst().trendPivotType();
        return new InstrumentSummaryDto.Pivots(latestPivotType, previousPivotType, latestTrendPivotType, events);
    }

    private LatestPriceSnapshotDto fetchLatestPrice(String marketSchema, long instrumentId, String timeframe) {
        String sql = """
                SELECT CAST(trade_date AS text) AS trade_date,
                       tf_id,
                       CAST(bar_start_ts AS text) AS bar_start_ts,
                       open, high, low, close, volume
                FROM %s.market_candle
                WHERE instrument_id = :instrumentId
                  AND timeframe = :timeframe
                ORDER BY bar_start_ts DESC, tf_id DESC
                LIMIT 1
                """.formatted(marketSchema);
        List<LatestPriceSnapshotDto> rows = jdbcTemplate.query(sql,
                new MapSqlParameterSource().addValue("instrumentId", instrumentId).addValue("timeframe", timeframe),
                (rs, rowNum) -> new LatestPriceSnapshotDto(
                        timeframe,
                        rs.getString("trade_date"),
                        rs.getLong("tf_id"),
                        rs.getString("bar_start_ts"),
                        rs.getDouble("open"),
                        rs.getDouble("high"),
                        rs.getDouble("low"),
                        rs.getDouble("close"),
                        rs.getObject("volume") != null ? rs.getDouble("volume") : null
                ));
        return rows.isEmpty() ? null : rows.getFirst();
    }

    private InstrumentSummaryDto.CandleAnalysis fetchCandleAnalysis(String marketSchema, long instrumentId) {
        String sql = """
                SELECT body_pct, upper_wick_pct, lower_wick_pct, range_to_atr
                FROM %s.market_candle_feature_fast
                WHERE instrument_id = :instrumentId
                  AND timeframe = 'day'
                ORDER BY bar_start_ts DESC, tf_id DESC
                LIMIT 1
                """.formatted(marketSchema);
        List<InstrumentSummaryDto.CandleAnalysis> rows = jdbcTemplate.query(sql,
                new MapSqlParameterSource("instrumentId", instrumentId),
                (rs, rowNum) -> new InstrumentSummaryDto.CandleAnalysis(
                        deriveCandlePattern(rs),
                        null,
                        getNullableDouble(rs, "body_pct"),
                        getNullableDouble(rs, "upper_wick_pct"),
                        getNullableDouble(rs, "lower_wick_pct"),
                        getNullableDouble(rs, "range_to_atr")
                ));
        return rows.isEmpty() ? new InstrumentSummaryDto.CandleAnalysis(null, null, null, null, null, null) : rows.getFirst();
    }

    private static InstrumentRowDto mapInstrumentRow(ResultSet rs) throws SQLException {
        return new InstrumentRowDto(
                rs.getLong("instrument_id"),
                rs.getString("symbol"),
                rs.getString("trading_symbol"),
                rs.getString("instrument_type"),
                rs.getString("sector"),
                rs.getString("exchange_code"),
                rs.getString("latest_trade_date"),
                rs.getBoolean("chart_data_exists"),
                parseJsonArrayText(rs.getString("chart_timeframes_available")),
                rs.getString("bootstrap_status"),
                rs.getString("chart_data_status"),
                rs.getString("trend_state_day"),
                rs.getString("current_candle_pattern_day"),
                rs.getString("latest_pivot_type_day"),
                rs.getString("latest_trend_pivot_type_day"),
                rs.getString("sma_structure_day"),
                rs.getString("updated_at")
        );
    }

    private static String deriveCandlePattern(ResultSet rs) throws SQLException {
        Double body = getNullableDouble(rs, "body_pct");
        Double upper = getNullableDouble(rs, "upper_wick_pct");
        Double lower = getNullableDouble(rs, "lower_wick_pct");
        if (body == null) return null;
        if (body >= 75 && lower != null && lower >= 50 && (upper == null || upper <= 10)) return "BOTTOM_TAIL";
        if (body >= 75 && upper != null && upper >= 50 && (lower == null || lower <= 10)) return "TOPPING_TAIL";
        if (body >= 60) return "STRONG_BODY";
        return "NEUTRAL";
    }

    private static Double getNullableDouble(ResultSet rs, String column) throws SQLException {
        Object value = rs.getObject(column);
        return value == null ? null : rs.getDouble(column);
    }

    private static MapSqlParameterSource params(InstrumentSearchRequestDto request, String exchangeCode) {
        return new MapSqlParameterSource()
                .addValue("exchangeCode", exchangeCode)
                .addValue("tradeDate", blankToNull(request.tradeDate()))
                .addValue("trendFilter", blankToNull(request.trendFilter()))
                .addValue("sector", blankToNull(request.sector()))
                .addValue("symbolQuery", blankToNull(request.symbolQuery()))
                .addValue("candleType", blankToNull(request.candleType()))
                .addValue("pivotType", blankToNull(request.pivotType()))
                .addValue("smaStructure", blankToNull(request.smaStructure()));
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value;
    }

    private static List<String> parseJsonArrayText(String raw) {
        if (raw == null || raw.isBlank()) return List.of();
        String cleaned = raw.replace("[", "").replace("]", "").replace("\"", "").trim();
        if (cleaned.isBlank()) return List.of();
        List<String> result = new ArrayList<>();
        for (String part : cleaned.split(",")) {
            String v = part.trim();
            if (!v.isBlank()) result.add(v);
        }
        return result;
    }

    private static String sanitizeTimeframe(String tf) {
        if (tf == null) throw new IllegalArgumentException("timeframe filter cannot be null");
        return switch (tf.toLowerCase()) {
            case "hour", "day", "week" -> tf.toLowerCase();
            default -> throw new IllegalArgumentException("Unsupported timeframe filter=" + tf);
        };
    }
}
