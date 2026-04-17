package com.rathore.stockanalysis.dashboard.repository.impl;

import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import com.rathore.stockanalysis.dashboard.dto.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardOverviewDto;
import com.rathore.stockanalysis.dashboard.repository.DashboardQueryRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DashboardQueryRepositoryImpl implements DashboardQueryRepository {

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;

    public DashboardQueryRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate,
                                        ExchangeSchemaRegistry exchangeSchemaRegistry) {
        this.jdbcTemplate = jdbcTemplate;
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
    }

    @Override
    public DashboardOverviewDto fetchOverview(String exchangeCode, String tradeDate, String timeframe) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String tradeDateColumn = switch (normalizeTimeframe(timeframe)) {
            case "hour" -> "latest_trade_date_hour";
            case "week" -> "latest_trade_date_week";
            default -> "latest_trade_date_day";
        };
        String trendColumn = switch (normalizeTimeframe(timeframe)) {
            case "hour" -> "COALESCE(NULLIF(snap.latest_market_trend_pivot_type_day, ''), snap.trend_state_day)";
            case "week" -> "snap.trend_state_day";
            default -> "snap.trend_state_day";
        };

        String sql = """
                WITH active_universe AS (
                    SELECT COUNT(*) AS total_active_instruments
                    FROM %s.instrument_master im
                    WHERE im.is_active = true
                ),
                snapshot AS (
                    SELECT *
                    FROM app_ui.instrument_latest_snapshot snap
                    WHERE snap.exchange_code = :exchangeCode
                      AND (:tradeDate IS NULL OR CAST(snap.%s AS text) = :tradeDate)
                )
                SELECT
                    au.total_active_instruments,
                    COUNT(*) FILTER (WHERE snap.chart_data_exists = true) AS instruments_with_data,
                    COUNT(*) FILTER (WHERE %s = 'UPTREND') AS uptrend_count,
                    COUNT(*) FILTER (WHERE %s = 'DOWNTREND') AS downtrend_count,
                    COUNT(*) FILTER (WHERE %s = 'SIDEWAYS') AS sideways_count,
                    MAX(CAST(snap.chart_to_date AS text)) AS latest_chart_to_date,
                    MAX(CAST(snap.last_bootstrap_completed_at AS text)) AS latest_bootstrap_completed_at,
                    COUNT(*) FILTER (WHERE snap.chart_data_exists = true AND snap.chart_timeframes_available_json::text LIKE '%%hour%%') AS hour_count,
                    COUNT(*) FILTER (WHERE snap.chart_data_exists = true AND snap.chart_timeframes_available_json::text LIKE '%%day%%') AS day_count,
                    COUNT(*) FILTER (WHERE snap.chart_data_exists = true AND snap.chart_timeframes_available_json::text LIKE '%%week%%') AS week_count
                FROM active_universe au
                LEFT JOIN snapshot snap ON true
                GROUP BY au.total_active_instruments
                """.formatted(schema.masterSchema(), tradeDateColumn, trendColumn, trendColumn, trendColumn);

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("exchangeCode", schema.exchangeCode())
                .addValue("tradeDate", blankToNull(tradeDate));

        DashboardOverviewDto overview = jdbcTemplate.queryForObject(sql, params, (rs, rowNum) ->
                new DashboardOverviewDto(
                        schema.exchangeCode(),
                        tradeDate,
                        normalizeTimeframe(timeframe),
                        rs.getLong("total_active_instruments"),
                        rs.getLong("instruments_with_data"),
                        rs.getLong("uptrend_count"),
                        rs.getLong("downtrend_count"),
                        rs.getLong("sideways_count"),
                        rs.getString("latest_chart_to_date"),
                        rs.getString("latest_bootstrap_completed_at"),
                        new DashboardOverviewDto.TimeframeCoverage(
                                rs.getLong("hour_count"),
                                rs.getLong("day_count"),
                                rs.getLong("week_count")
                        ),
                        fetchSectorBuckets(schema.exchangeCode(), tradeDate)
                ));

        if (overview == null) {
            return new DashboardOverviewDto(schema.exchangeCode(), tradeDate, normalizeTimeframe(timeframe), 0,0,0,0,0,null,null,
                    new DashboardOverviewDto.TimeframeCoverage(0,0,0), List.of());
        }
        return overview;
    }

    private List<DashboardOverviewDto.SectorBucket> fetchSectorBuckets(String exchangeCode, String tradeDate) {
        String sql = """
                SELECT
                    COALESCE(eq.sector, 'UNKNOWN') AS sector,
                    COUNT(*) AS total,
                    COUNT(*) FILTER (WHERE snap.trend_state_day = 'UPTREND') AS uptrend,
                    COUNT(*) FILTER (WHERE snap.trend_state_day = 'DOWNTREND') AS downtrend,
                    COUNT(*) FILTER (WHERE snap.trend_state_day = 'SIDEWAYS') AS sideways
                FROM app_ui.instrument_latest_snapshot snap
                LEFT JOIN nse_exchange_symbol.instrument_master_equity eq
                    ON eq.instrument_id = snap.instrument_id
                WHERE snap.exchange_code = :exchangeCode
                  AND snap.chart_data_exists = true
                  AND (:tradeDate IS NULL OR CAST(snap.latest_trade_date_day AS text) = :tradeDate)
                GROUP BY COALESCE(eq.sector, 'UNKNOWN')
                ORDER BY total DESC, sector ASC
                LIMIT 20
                """;
        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("exchangeCode", exchangeCode)
                .addValue("tradeDate", blankToNull(tradeDate));
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new DashboardOverviewDto.SectorBucket(
                rs.getString("sector"),
                rs.getLong("total"),
                rs.getLong("uptrend"),
                rs.getLong("downtrend"),
                rs.getLong("sideways")
        ));
    }

    @Override
    public DataCoverageDto fetchDataCoverage(String exchangeCode) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        String summarySql = """
                SELECT
                    COUNT(*) FILTER (WHERE im.is_active = true) AS total_active_instruments,
                    COUNT(*) FILTER (WHERE icb.chart_data_exists = true) AS chart_data_exists_count,
                    COUNT(*) FILTER (WHERE icb.chart_data_status = 'STALE') AS stale_count,
                    COUNT(*) FILTER (WHERE icb.bootstrap_status IN ('REBUILD_REQUIRED', 'FAILED')) AS rebuild_required_count,
                    COUNT(*) FILTER (WHERE icb.chart_timeframes_available_json::text LIKE '%%hour%%') AS hour_count,
                    COUNT(*) FILTER (WHERE icb.chart_timeframes_available_json::text LIKE '%%day%%') AS day_count,
                    COUNT(*) FILTER (WHERE icb.chart_timeframes_available_json::text LIKE '%%week%%') AS week_count
                FROM %s.instrument_master im
                LEFT JOIN %s.instrument_chart_bootstrap icb
                  ON icb.instrument_id = im.instrument_id
                WHERE im.is_active = true
                """.formatted(schema.masterSchema(), schema.masterSchema());

        DataCoverageDto base = jdbcTemplate.queryForObject(summarySql, new MapSqlParameterSource(), (rs, rowNum) ->
                new DataCoverageDto(
                        schema.exchangeCode(),
                        rs.getLong("total_active_instruments"),
                        rs.getLong("chart_data_exists_count"),
                        rs.getLong("stale_count"),
                        rs.getLong("rebuild_required_count"),
                        fetchStatusCounts(schema.masterSchema(), "bootstrap_status"),
                        fetchStatusCounts(schema.masterSchema(), "chart_data_status"),
                        new DataCoverageDto.TimeframeAvailability(
                                rs.getLong("hour_count"),
                                rs.getLong("day_count"),
                                rs.getLong("week_count")
                        )
                ));
        return base;
    }

    private List<DataCoverageDto.StatusCount> fetchStatusCounts(String masterSchema, String columnName) {
        String sql = """
                SELECT COALESCE(CAST(%s AS text), 'UNKNOWN') AS status, COUNT(*) AS count
                FROM %s.instrument_chart_bootstrap
                GROUP BY COALESCE(CAST(%s AS text), 'UNKNOWN')
                ORDER BY count DESC, status ASC
                """.formatted(columnName, masterSchema, columnName);
        return jdbcTemplate.query(sql, new MapSqlParameterSource(), (rs, rowNum) ->
                new DataCoverageDto.StatusCount(rs.getString("status"), rs.getLong("count"))
        );
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value;
    }

    private static String normalizeTimeframe(String timeframe) {
        if (timeframe == null || timeframe.isBlank()) {
            return "day";
        }
        return switch (timeframe.toLowerCase()) {
            case "hour", "day", "week" -> timeframe.toLowerCase();
            default -> throw new IllegalArgumentException("Unsupported timeframe=" + timeframe);
        };
    }
}
