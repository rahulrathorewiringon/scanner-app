package com.rathore.stockanalysis.chart.repository.impl;

import com.rathore.stockanalysis.chart.dto.*;
import com.rathore.stockanalysis.chart.repository.ChartQueryRepository;
import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ChartQueryRepositoryImpl implements ChartQueryRepository {

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;

    public ChartQueryRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate,
                                    ExchangeSchemaRegistry exchangeSchemaRegistry) {
        this.jdbcTemplate = jdbcTemplate;
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
    }

    @Override
    public String fetchSymbol(String exchangeCode, long instrumentId) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String sql = "SELECT symbol FROM %s.instrument_master WHERE instrument_id = :instrumentId".formatted(schema.masterSchema());
        return jdbcTemplate.queryForObject(sql, new MapSqlParameterSource("instrumentId", instrumentId), String.class);
    }

    @Override
    public ChartSeriesDto fetchSeries(String exchangeCode, long instrumentId, String timeframe) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String tf = normalizeTimeframe(timeframe);
        String sql = """
                SELECT CAST(bar_start_ts AS text) AS bar_start_ts,
                       CAST(bar_end_ts AS text) AS bar_end_ts,
                       CAST(trade_date AS text) AS trade_date,
                       tf_id,
                       open, high, low, close, volume
                FROM %s.market_candle
                WHERE instrument_id = :instrumentId
                  AND timeframe = :timeframe
                ORDER BY bar_start_ts ASC, tf_id ASC
                """.formatted(schema.marketSchema());
        List<ChartCandleDto> candles = jdbcTemplate.query(sql,
                new MapSqlParameterSource().addValue("instrumentId", instrumentId).addValue("timeframe", tf),
                (rs, rowNum) -> new ChartCandleDto(
                        rs.getString("bar_start_ts"),
                        rs.getString("bar_end_ts"),
                        rs.getString("trade_date"),
                        rs.getLong("tf_id"),
                        rs.getDouble("open"),
                        rs.getDouble("high"),
                        rs.getDouble("low"),
                        rs.getDouble("close"),
                        rs.getObject("volume") != null ? rs.getDouble("volume") : null
                ));
        return new ChartSeriesDto(tf, candles);
    }

    @Override
    public ChartOverlayDto fetchOverlay(String exchangeCode, long instrumentId, String timeframe, boolean includeSma, boolean includePivots) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String tf = normalizeTimeframe(timeframe);
        ChartOverlayDto.SmaOverlay sma = includeSma ? fetchSmaOverlay(schema.marketSchema(), instrumentId, tf) : null;
        List<PivotMarkerDto> pivots = includePivots ? fetchPivotMarkers(schema.marketSchema(), instrumentId, tf) : null;
        return new ChartOverlayDto(sma, pivots);
    }

    private ChartOverlayDto.SmaOverlay fetchSmaOverlay(String marketSchema, long instrumentId, String timeframe) {
        String sql = """
                SELECT CAST(bar_start_ts AS text) AS bar_start_ts,
                       sma_5, sma_10, sma_20, sma_50, sma_100, sma_200
                FROM %s.market_candle_feature_fast
                WHERE instrument_id = :instrumentId
                  AND timeframe = :timeframe
                ORDER BY bar_start_ts ASC, tf_id ASC
                """.formatted(marketSchema);
        List<LinePointDto> sma5 = new java.util.ArrayList<>();
        List<LinePointDto> sma10 = new java.util.ArrayList<>();
        List<LinePointDto> sma20 = new java.util.ArrayList<>();
        List<LinePointDto> sma50 = new java.util.ArrayList<>();
        List<LinePointDto> sma100 = new java.util.ArrayList<>();
        List<LinePointDto> sma200 = new java.util.ArrayList<>();
        jdbcTemplate.query(sql,
                new MapSqlParameterSource().addValue("instrumentId", instrumentId).addValue("timeframe", timeframe),
                rs -> {
                    String time = rs.getString("bar_start_ts");
                    addLinePoint(sma5, time, rs.getObject("sma_5"), rs.getDouble("sma_5"));
                    addLinePoint(sma10, time, rs.getObject("sma_10"), rs.getDouble("sma_10"));
                    addLinePoint(sma20, time, rs.getObject("sma_20"), rs.getDouble("sma_20"));
                    addLinePoint(sma50, time, rs.getObject("sma_50"), rs.getDouble("sma_50"));
                    addLinePoint(sma100, time, rs.getObject("sma_100"), rs.getDouble("sma_100"));
                    addLinePoint(sma200, time, rs.getObject("sma_200"), rs.getDouble("sma_200"));
                });
        return new ChartOverlayDto.SmaOverlay(sma5, sma10, sma20, sma50, sma100, sma200);
    }

    private List<PivotMarkerDto> fetchPivotMarkers(String marketSchema, long instrumentId, String timeframe) {
        String sql = """
                SELECT CAST(bar_start_ts AS text) AS bar_start_ts,
                       pivot_type,
                       pivot_confirmed,
                       pivot_price,
                       trend_pivot_type
                FROM %s.market_candle_pivot
                WHERE instrument_id = :instrumentId
                  AND timeframe = :timeframe
                ORDER BY bar_start_ts ASC, tf_id ASC
                """.formatted(marketSchema);
        return jdbcTemplate.query(sql,
                new MapSqlParameterSource().addValue("instrumentId", instrumentId).addValue("timeframe", timeframe),
                (rs, rowNum) -> new PivotMarkerDto(
                        rs.getString("bar_start_ts"),
                        rs.getString("pivot_type"),
                        rs.getBoolean("pivot_confirmed"),
                        rs.getObject("pivot_price") != null ? rs.getDouble("pivot_price") : null,
                        rs.getString("trend_pivot_type")
                ));
    }

    private static void addLinePoint(List<LinePointDto> target, String time, Object raw, double value) {
        if (raw != null) {
            target.add(new LinePointDto(time, value));
        }
    }

    private static String normalizeTimeframe(String timeframe) {
        if (timeframe == null || timeframe.isBlank()) return "day";
        return switch (timeframe.toLowerCase()) {
            case "hour", "day", "week" -> timeframe.toLowerCase();
            default -> throw new IllegalArgumentException("Unsupported timeframe=" + timeframe);
        };
    }
}
