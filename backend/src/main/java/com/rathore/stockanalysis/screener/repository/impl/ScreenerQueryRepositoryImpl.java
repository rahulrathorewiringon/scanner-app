package com.rathore.stockanalysis.screener.repository.impl;

import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import com.rathore.stockanalysis.screener.repository.ScreenerQueryRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class ScreenerQueryRepositoryImpl implements ScreenerQueryRepository {

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;

    private static final Set<String> ALLOWED_OPERATORS = Set.of("eq", "neq", "gt", "gte", "lt", "lte", "in", "contains");
    private static final Map<String, String> SORT_MAP = Map.of(
            "symbol", "snap.symbol",
            "latestClose", "snap.latest_close_day",
            "latestPivotType", "snap.latest_pivot_type_day",
            "currentCandleType", "snap.current_candle_pattern_day",
            "updatedAt", "snap.updated_at"
    );

    public ScreenerQueryRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate, ExchangeSchemaRegistry exchangeSchemaRegistry) {
        this.jdbcTemplate = jdbcTemplate;
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
    }

    @Override
    public long count(String exchangeCode, ScreenerDtos.ScreenerRunRequestDto request) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        QueryParts qp = buildFilterWhereClause(request);
        String sql = """
                SELECT COUNT(*)
                FROM app_ui.instrument_latest_snapshot snap
                LEFT JOIN %s.instrument_master_equity eq
                  ON eq.instrument_id = snap.instrument_id
                WHERE snap.exchange_code = :exchangeCode
                  AND COALESCE(snap.chart_data_exists, false) = true
                  AND (:tradeDate IS NULL OR CAST(COALESCE(snap.latest_trade_date_day, snap.latest_trade_date_hour, snap.latest_trade_date_week) AS text) = :tradeDate)
                  %s
                """.formatted(schema.masterSchema(), qp.whereClause());
        MapSqlParameterSource params = qp.params()
                .addValue("exchangeCode", schema.exchangeCode())
                .addValue("tradeDate", blankToNull(request.tradeDate()));
        Long result = jdbcTemplate.queryForObject(sql, params, Long.class);
        return result == null ? 0L : result;
    }

    @Override
    public ScreenerDtos.ScreenerRunResponseDto run(String exchangeCode, ScreenerDtos.ScreenerRunRequestDto request) {
        ExchangeSchema schema = exchangeSchemaRegistry.resolve(exchangeCode);
        QueryParts qp = buildFilterWhereClause(request);
        int pageIndex = request.pagination() != null ? request.pagination().pageIndex() : 0;
        int pageSize = request.pagination() != null ? request.pagination().pageSize() : 50;
        int offset = pageIndex * pageSize;
        long totalRows = count(exchangeCode, request);
        String orderBy = buildOrderBy(request.sort());
        String sql = """
                SELECT
                    snap.instrument_id,
                    snap.symbol,
                    eq.sector,
                    :timeframe AS timeframe,
                    CASE :timeframe
                        WHEN 'hour' THEN snap.latest_close_hour
                        WHEN 'week' THEN snap.latest_close_week
                        ELSE snap.latest_close_day
                    END AS latest_close,
                    CASE :timeframe
                        WHEN 'hour' THEN COALESCE(snap.current_candle_pattern_hour, snap.current_candle_pattern_day)
                        WHEN 'week' THEN COALESCE(snap.current_candle_pattern_week, snap.current_candle_pattern_day)
                        ELSE snap.current_candle_pattern_day
                    END AS current_candle_type,
                    CASE :timeframe
                        WHEN 'hour' THEN COALESCE(snap.latest_pivot_type_hour, snap.latest_pivot_type_day)
                        WHEN 'week' THEN COALESCE(snap.latest_pivot_type_week, snap.latest_pivot_type_day)
                        ELSE snap.latest_pivot_type_day
                    END AS latest_pivot_type,
                    CASE :timeframe
                        WHEN 'hour' THEN COALESCE(snap.previous_pivot_type_hour, snap.previous_pivot_type_day)
                        WHEN 'week' THEN COALESCE(snap.previous_pivot_type_week, snap.previous_pivot_type_day)
                        ELSE snap.previous_pivot_type_day
                    END AS previous_pivot_type,
                    CASE :timeframe
                        WHEN 'hour' THEN snap.sma_structure_hour
                        WHEN 'week' THEN snap.sma_structure_week
                        ELSE snap.sma_structure_day
                    END AS sma_alignment_summary,
                    snap.trend_state_day AS signal_summary,
                    CAST(snap.updated_at AS text) AS updated_at
                FROM app_ui.instrument_latest_snapshot snap
                LEFT JOIN %s.instrument_master_equity eq
                  ON eq.instrument_id = snap.instrument_id
                WHERE snap.exchange_code = :exchangeCode
                  AND COALESCE(snap.chart_data_exists, false) = true
                  AND (:tradeDate IS NULL OR CAST(COALESCE(snap.latest_trade_date_day, snap.latest_trade_date_hour, snap.latest_trade_date_week) AS text) = :tradeDate)
                  %s
                %s
                LIMIT :limit OFFSET :offset
                """.formatted(schema.masterSchema(), qp.whereClause(), orderBy);
        MapSqlParameterSource params = qp.params()
                .addValue("exchangeCode", schema.exchangeCode())
                .addValue("tradeDate", blankToNull(request.tradeDate()))
                .addValue("timeframe", normalizeTimeframe(request.defaultTimeframe()))
                .addValue("limit", pageSize)
                .addValue("offset", offset);
        List<ScreenerDtos.ScreenerResultRowDto> rows = jdbcTemplate.query(sql, params, (rs, rowNum) -> mapRow(rs));
        return new ScreenerDtos.ScreenerRunResponseDto(rows, totalRows, pageIndex, pageSize);
    }

    private QueryParts buildFilterWhereClause(ScreenerDtos.ScreenerRunRequestDto request) {
        if (request.filterTree() == null || request.filterTree().children() == null || request.filterTree().children().isEmpty()) {
            return new QueryParts("", new MapSqlParameterSource());
        }
        AtomicInteger seq = new AtomicInteger(0);
        MapSqlParameterSource params = new MapSqlParameterSource();
        String root = buildGroupClause(request.filterTree(), params, seq, normalizeTimeframe(request.defaultTimeframe()));
        if (root == null || root.isBlank()) {
            return new QueryParts("", params);
        }
        return new QueryParts(" AND (" + root + ")", params);
    }

    private String buildGroupClause(ScreenerDtos.ScreenerFilterGroupDto group,
                                    MapSqlParameterSource params,
                                    AtomicInteger seq,
                                    String defaultTimeframe) {
        if (!group.enabled() || group.children() == null || group.children().isEmpty()) {
            return "";
        }
        List<String> clauses = new ArrayList<>();
        for (Object child : group.children()) {
            if (!(child instanceof Map<?, ?> map)) continue;
            Object typeObj = map.get("type");
            String type = typeObj == null ? null : String.valueOf(typeObj);
            if ("group".equalsIgnoreCase(type)) {
                ScreenerDtos.ScreenerFilterGroupDto nested = mapToGroup(map);
                String nestedClause = buildGroupClause(nested, params, seq, defaultTimeframe);
                if (!nestedClause.isBlank()) clauses.add("(" + nestedClause + ")");
            } else if ("condition".equalsIgnoreCase(type)) {
                String condition = buildConditionClause(map, params, seq, defaultTimeframe);
                if (!condition.isBlank()) clauses.add(condition);
            }
        }
        if (clauses.isEmpty()) return "";
        String op = "OR".equalsIgnoreCase(group.operator()) ? " OR " : " AND ";
        return String.join(op, clauses);
    }

    private ScreenerDtos.ScreenerFilterGroupDto mapToGroup(Map<?, ?> map) {
        Object children = map.get("children");
        String type = asString(map.get("type"));
        String id = asString(map.get("id"));
        String operator = asString(map.get("operator"));
        return new ScreenerDtos.ScreenerFilterGroupDto(
                type == null || type.isBlank() ? "group" : type,
                id == null || id.isBlank() ? UUID.randomUUID().toString() : id,
                operator == null || operator.isBlank() ? "AND" : operator,
                !Boolean.FALSE.equals(map.get("enabled")),
                children instanceof List<?> list ? new ArrayList<>(list) : List.of()
        );
    }

    private String buildConditionClause(Map<?, ?> map,
                                        MapSqlParameterSource params,
                                        AtomicInteger seq,
                                        String defaultTimeframe) {
        if (Boolean.FALSE.equals(map.get("enabled"))) return "";
        String field = asString(map.get("field"));
        String operator = asString(map.get("operator"));
        String timeframe = asString(map.get("timeframe"));
        if (timeframe == null || timeframe.isBlank() || "current".equalsIgnoreCase(timeframe)) {
            timeframe = defaultTimeframe;
        }
        timeframe = normalizeTimeframe(timeframe);
        if (!ALLOWED_OPERATORS.contains(operator)) {
            throw new IllegalArgumentException("Unsupported screener operator=" + operator);
        }
        String column = resolveColumn(field, timeframe);
        Object rawValue = map.get("value");
        if (!(rawValue instanceof Map<?, ?> valueMap)) return "";
        String kind = asString(valueMap.get("kind"));
        String paramBase = "p" + seq.incrementAndGet();
        return switch (operator) {
            case "eq" -> {
                Object v = valueOf(valueMap, kind);
                params.addValue(paramBase, v);
                yield column + " = :" + paramBase;
            }
            case "neq" -> {
                Object v = valueOf(valueMap, kind);
                params.addValue(paramBase, v);
                yield column + " <> :" + paramBase;
            }
            case "gt", "gte", "lt", "lte" -> {
                Object v = valueOf(valueMap, kind);
                params.addValue(paramBase, v);
                String op = switch (operator) {
                    case "gt" -> ">";
                    case "gte" -> ">=";
                    case "lt" -> "<";
                    default -> "<=";
                };
                yield column + " " + op + " :" + paramBase;
            }
            case "contains" -> {
                Object v = valueOf(valueMap, kind);
                params.addValue(paramBase, "%" + v + "%");
                yield column + " ILIKE :" + paramBase;
            }
            case "in" -> {
                Object values = valueMap.get("values");
                if (!(values instanceof List<?> list) || list.isEmpty()) yield "";
                params.addValue(paramBase, list);
                yield column + " IN (:" + paramBase + ")";
            }
            default -> "";
        };
    }

    private Object valueOf(Map<?, ?> valueMap, String kind) {
        if ("single".equalsIgnoreCase(kind)) return valueMap.get("value");
        if ("relative".equalsIgnoreCase(kind)) return valueMap.get("value");
        throw new IllegalArgumentException("Unsupported screener value kind=" + kind);
    }

    private String resolveColumn(String field, String timeframe) {
        return switch (field) {
            case "symbol" -> "snap.symbol";
            case "sector" -> "eq.sector";
            case "trendState", "signalState" -> "snap.trend_state_day";
            case "currentCandleType", "current_candle_pattern" -> switch (timeframe) {
                case "hour" -> "COALESCE(snap.current_candle_pattern_hour, snap.current_candle_pattern_day)";
                case "week" -> "COALESCE(snap.current_candle_pattern_week, snap.current_candle_pattern_day)";
                default -> "snap.current_candle_pattern_day";
            };
            case "latestPivotType" -> switch (timeframe) {
                case "hour" -> "COALESCE(snap.latest_pivot_type_hour, snap.latest_pivot_type_day)";
                case "week" -> "COALESCE(snap.latest_pivot_type_week, snap.latest_pivot_type_day)";
                default -> "snap.latest_pivot_type_day";
            };
            case "previousPivotType" -> switch (timeframe) {
                case "hour" -> "COALESCE(snap.previous_pivot_type_hour, snap.previous_pivot_type_day)";
                case "week" -> "COALESCE(snap.previous_pivot_type_week, snap.previous_pivot_type_day)";
                default -> "snap.previous_pivot_type_day";
            };
            case "smaStructure", "smaAlignment" -> switch (timeframe) {
                case "hour" -> "snap.sma_structure_hour";
                case "week" -> "snap.sma_structure_week";
                default -> "snap.sma_structure_day";
            };
            case "latestClose" -> switch (timeframe) {
                case "hour" -> "snap.latest_close_hour";
                case "week" -> "snap.latest_close_week";
                default -> "snap.latest_close_day";
            };
            default -> throw new IllegalArgumentException("Unsupported screener field=" + field);
        };
    }

    private ScreenerDtos.ScreenerResultRowDto mapRow(ResultSet rs) throws SQLException {
        return new ScreenerDtos.ScreenerResultRowDto(
                rs.getLong("instrument_id"),
                rs.getString("symbol"),
                rs.getString("sector"),
                rs.getString("timeframe"),
                rs.getObject("latest_close") != null ? rs.getDouble("latest_close") : null,
                rs.getString("current_candle_type"),
                rs.getString("latest_pivot_type"),
                rs.getString("previous_pivot_type"),
                rs.getString("sma_alignment_summary"),
                rs.getString("signal_summary"),
                rs.getString("updated_at")
        );
    }

    private String buildOrderBy(List<ScreenerDtos.ScreenerRunRequestDto.SortDef> sort) {
        if (sort == null || sort.isEmpty()) return "ORDER BY snap.symbol ASC";
        List<String> parts = new ArrayList<>();
        for (ScreenerDtos.ScreenerRunRequestDto.SortDef spec : sort) {
            String column = SORT_MAP.get(spec.field());
            if (column == null) continue;
            String direction = "desc".equalsIgnoreCase(spec.direction()) ? "DESC" : "ASC";
            parts.add(column + " " + direction);
        }
        return parts.isEmpty() ? "ORDER BY snap.symbol ASC" : "ORDER BY " + String.join(", ", parts);
    }

    private static String asString(Object value) {
        return value == null ? null : String.valueOf(value);
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value;
    }

    private static String normalizeTimeframe(String timeframe) {
        if (timeframe == null || timeframe.isBlank()) return "day";
        return switch (timeframe.toLowerCase()) {
            case "hour", "day", "week" -> timeframe.toLowerCase();
            default -> throw new IllegalArgumentException("Unsupported timeframe=" + timeframe);
        };
    }

    private record QueryParts(String whereClause, MapSqlParameterSource params) {}
}
