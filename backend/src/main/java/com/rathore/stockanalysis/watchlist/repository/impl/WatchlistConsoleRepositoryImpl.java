package com.rathore.stockanalysis.watchlist.repository.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rathore.stockanalysis.preference.repository.impl.UserPreferenceRepositoryImpl;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import com.rathore.stockanalysis.screener.repository.ScreenerQueryRepository;
import com.rathore.stockanalysis.watchlist.dto.WatchlistDtos;
import com.rathore.stockanalysis.watchlist.repository.WatchlistConsoleRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@Repository
public class WatchlistConsoleRepositoryImpl implements WatchlistConsoleRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ScreenerQueryRepository screenerQueryRepository;
    private final UserPreferenceRepositoryImpl userPreferenceRepository;
    private final ObjectMapper objectMapper;

    public WatchlistConsoleRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate,
                                          ScreenerQueryRepository screenerQueryRepository,
                                          UserPreferenceRepositoryImpl userPreferenceRepository,
                                          ObjectMapper objectMapper) {
        this.jdbcTemplate = jdbcTemplate;
        this.screenerQueryRepository = screenerQueryRepository;
        this.userPreferenceRepository = userPreferenceRepository;
        this.objectMapper = objectMapper;
    }

    @Override
    public List<WatchlistDtos.WatchlistDefinitionDto> listWatchlists(String userId) {
        return jdbcTemplate.query("""
                SELECT watchlist_id, user_id, name, exchange_code, watchlist_type, rule_engine_type,
                       CAST(created_at AS text) AS created_at,
                       CAST(updated_at AS text) AS updated_at
                FROM app_ui.watchlist_definition
                WHERE user_id = :userId
                ORDER BY updated_at DESC, name ASC
                """, new MapSqlParameterSource("userId", userId), (rs, i) -> mapWatchlist(rs));
    }

    @Override
    public WatchlistDtos.WatchlistDefinitionDto createWatchlist(WatchlistDtos.CreateWatchlistRequestDto request) {
        UUID id = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.watchlist_definition (watchlist_id, user_id, name, exchange_code, watchlist_type, rule_engine_type)
                VALUES (:id, :userId, :name, :exchangeCode, :watchlistType, :ruleEngineType)
                """, new MapSqlParameterSource().addValue("id", id).addValue("userId", request.userId()).addValue("name", request.name()).addValue("exchangeCode", request.exchangeCode()).addValue("watchlistType", request.watchlistType() == null ? "MANUAL" : request.watchlistType()).addValue("ruleEngineType", request.ruleEngineType()));
        return getWatchlist(request.userId(), id);
    }

    @Override
    public WatchlistDtos.WatchlistDefinitionDto updateWatchlist(WatchlistDtos.UpdateWatchlistRequestDto request) {
        jdbcTemplate.update("""
                UPDATE app_ui.watchlist_definition
                SET name=:name, exchange_code=:exchangeCode, watchlist_type=:watchlistType, rule_engine_type=:ruleEngineType, updated_at=now()
                WHERE watchlist_id=:watchlistId AND user_id=:userId
                """, new MapSqlParameterSource().addValue("watchlistId", request.watchlistId()).addValue("userId", request.userId()).addValue("name", request.name()).addValue("exchangeCode", request.exchangeCode()).addValue("watchlistType", request.watchlistType()).addValue("ruleEngineType", request.ruleEngineType()));
        return getWatchlist(request.userId(), request.watchlistId());
    }

    @Override
    public void deleteWatchlist(UUID watchlistId, String userId) {
        jdbcTemplate.update("DELETE FROM app_ui.watchlist_definition WHERE watchlist_id=:watchlistId AND user_id=:userId", new MapSqlParameterSource().addValue("watchlistId", watchlistId).addValue("userId", userId));
    }

    @Override
    public WatchlistDtos.WatchlistDetailDto getWatchlistDetail(String userId, UUID watchlistId) {
        return new WatchlistDtos.WatchlistDetailDto(getWatchlist(userId, watchlistId), listWatchlistItems(userId, watchlistId),
                jdbcTemplate.query("""
                    SELECT rule_id, watchlist_id, user_id, name, exchange_code, rule_type, rule_definition,
                           is_enabled, CAST(last_generated_at AS text) AS last_generated_at,
                           CAST(created_at AS text) AS created_at,
                           CAST(updated_at AS text) AS updated_at
                    FROM app_ui.watchlist_generation_rule
                    WHERE user_id=:userId AND watchlist_id=:watchlistId
                    ORDER BY updated_at DESC
                """, new MapSqlParameterSource().addValue("userId", userId).addValue("watchlistId", watchlistId), (rs,i)->mapRule(rs)));
    }

    @Override
    public List<WatchlistDtos.WatchlistItemDto> listWatchlistItems(String userId, UUID watchlistId) {
        return jdbcTemplate.query("""
                SELECT wi.watchlist_item_id, wi.watchlist_id, wi.instrument_id, ils.symbol, wi.note,
                       CAST(wi.source_rule_id AS text) AS source_rule_id,
                       CAST(wi.created_at AS text) AS created_at
                FROM app_ui.watchlist_item wi
                JOIN app_ui.watchlist_definition wd ON wd.watchlist_id = wi.watchlist_id
                LEFT JOIN app_ui.instrument_latest_snapshot ils ON ils.instrument_id = wi.instrument_id AND ils.exchange_code = wd.exchange_code
                WHERE wd.user_id = :userId AND wi.watchlist_id = :watchlistId
                ORDER BY wi.created_at DESC
                """, new MapSqlParameterSource().addValue("userId", userId).addValue("watchlistId", watchlistId), (rs, i) -> mapWatchlistItem(rs));
    }

    @Override
    public WatchlistDtos.WatchlistItemDto addWatchlistItem(UUID watchlistId, WatchlistDtos.CreateWatchlistItemRequestDto request) {
        UUID itemId = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.watchlist_item (watchlist_item_id, watchlist_id, instrument_id, note)
                VALUES (:itemId, :watchlistId, :instrumentId, :note)
                ON CONFLICT (watchlist_id, instrument_id) DO UPDATE SET note=EXCLUDED.note
                """, new MapSqlParameterSource().addValue("itemId", itemId).addValue("watchlistId", watchlistId).addValue("instrumentId", request.instrumentId()).addValue("note", request.note()));
        return jdbcTemplate.queryForObject("""
                SELECT wi.watchlist_item_id, wi.watchlist_id, wi.instrument_id, ils.symbol, wi.note,
                       CAST(wi.source_rule_id AS text) AS source_rule_id, CAST(wi.created_at AS text) AS created_at
                FROM app_ui.watchlist_item wi
                JOIN app_ui.watchlist_definition wd ON wd.watchlist_id = wi.watchlist_id
                LEFT JOIN app_ui.instrument_latest_snapshot ils ON ils.instrument_id = wi.instrument_id AND ils.exchange_code = wd.exchange_code
                WHERE wi.watchlist_id=:watchlistId AND wi.instrument_id=:instrumentId
                """, new MapSqlParameterSource().addValue("watchlistId", watchlistId).addValue("instrumentId", request.instrumentId()), (rs,i)->mapWatchlistItem(rs));
    }

    @Override
    public WatchlistDtos.WatchlistItemDto updateWatchlistItem(UUID watchlistId, WatchlistDtos.UpdateWatchlistItemRequestDto request) {
        jdbcTemplate.update("""
                UPDATE app_ui.watchlist_item wi
                SET note=:note
                FROM app_ui.watchlist_definition wd
                WHERE wi.watchlist_id=:watchlistId AND wi.watchlist_item_id=:watchlistItemId AND wd.watchlist_id=wi.watchlist_id AND wd.user_id=:userId
                """, new MapSqlParameterSource().addValue("watchlistId", watchlistId).addValue("watchlistItemId", request.watchlistItemId()).addValue("userId", request.userId()).addValue("note", request.note()));
        return jdbcTemplate.queryForObject("""
                SELECT wi.watchlist_item_id, wi.watchlist_id, wi.instrument_id, ils.symbol, wi.note,
                       CAST(wi.source_rule_id AS text) AS source_rule_id, CAST(wi.created_at AS text) AS created_at
                FROM app_ui.watchlist_item wi
                JOIN app_ui.watchlist_definition wd ON wd.watchlist_id = wi.watchlist_id
                LEFT JOIN app_ui.instrument_latest_snapshot ils ON ils.instrument_id = wi.instrument_id AND ils.exchange_code = wd.exchange_code
                WHERE wi.watchlist_item_id=:watchlistItemId AND wd.user_id=:userId
                """, new MapSqlParameterSource().addValue("watchlistItemId", request.watchlistItemId()).addValue("userId", request.userId()), (rs,i)->mapWatchlistItem(rs));
    }

    @Override
    public void deleteWatchlistItem(UUID watchlistId, UUID watchlistItemId, String userId) {
        jdbcTemplate.update("""
                DELETE FROM app_ui.watchlist_item wi USING app_ui.watchlist_definition wd
                WHERE wi.watchlist_id=:watchlistId AND wi.watchlist_item_id=:watchlistItemId AND wd.watchlist_id=wi.watchlist_id AND wd.user_id=:userId
                """, new MapSqlParameterSource().addValue("watchlistId", watchlistId).addValue("watchlistItemId", watchlistItemId).addValue("userId", userId));
    }

    @Override
    public List<WatchlistDtos.AlertRuleDto> listAlertRules(String userId) {
        return jdbcTemplate.query("""
                SELECT ar.alert_rule_id, ar.user_id, ar.exchange_code, ar.instrument_id, ils.symbol,
                       ar.rule_name, ar.rule_type, ar.status, ar.source_watchlist_id, CAST(ar.config_json AS text) AS config_json,
                       CAST(ar.created_at AS text) AS created_at, CAST(ar.updated_at AS text) AS updated_at
                FROM app_ui.alert_rule ar
                LEFT JOIN app_ui.instrument_latest_snapshot ils ON ils.instrument_id = ar.instrument_id AND ils.exchange_code = ar.exchange_code
                WHERE ar.user_id = :userId ORDER BY ar.updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, i) -> mapAlertRule(rs));
    }

    @Override
    public WatchlistDtos.AlertRuleDto getAlertRuleDetail(String userId, UUID alertRuleId) {
        return jdbcTemplate.queryForObject("""
                SELECT ar.alert_rule_id, ar.user_id, ar.exchange_code, ar.instrument_id, ils.symbol,
                       ar.rule_name, ar.rule_type, ar.status, ar.source_watchlist_id, CAST(ar.config_json AS text) AS config_json,
                       CAST(ar.created_at AS text) AS created_at, CAST(ar.updated_at AS text) AS updated_at
                FROM app_ui.alert_rule ar
                LEFT JOIN app_ui.instrument_latest_snapshot ils ON ils.instrument_id = ar.instrument_id AND ils.exchange_code = ar.exchange_code
                WHERE ar.user_id = :userId AND ar.alert_rule_id=:alertRuleId
                """, new MapSqlParameterSource().addValue("userId", userId).addValue("alertRuleId", alertRuleId), (rs,i)->mapAlertRule(rs));
    }

    @Override
    public WatchlistDtos.AlertRuleDto updateAlertRule(WatchlistDtos.UpdateAlertRuleRequestDto request) {
        jdbcTemplate.update("""
                UPDATE app_ui.alert_rule
                SET rule_name=:ruleName, rule_type=:ruleType, status=:status, config_json=CAST(:configJson AS jsonb), updated_at=now()
                WHERE alert_rule_id=:alertRuleId AND user_id=:userId
                """, new MapSqlParameterSource().addValue("alertRuleId", request.alertRuleId()).addValue("userId", request.userId()).addValue("ruleName", request.ruleName()).addValue("ruleType", request.ruleType()).addValue("status", request.status()).addValue("configJson", request.configJson() == null ? "{}" : request.configJson()));
        return getAlertRuleDetail(request.userId(), request.alertRuleId());
    }

    @Override
    public void deleteAlertRule(UUID alertRuleId, String userId) {
        jdbcTemplate.update("DELETE FROM app_ui.alert_rule WHERE alert_rule_id=:alertRuleId AND user_id=:userId", new MapSqlParameterSource().addValue("alertRuleId", alertRuleId).addValue("userId", userId));
    }

    @Override
    public List<WatchlistDtos.WatchlistGenerationRuleDto> listWatchlistGenerationRules(String userId) {
        return jdbcTemplate.query("""
                SELECT rule_id, watchlist_id, user_id, name, exchange_code, rule_type, rule_definition,
                       is_enabled, CAST(last_generated_at AS text) AS last_generated_at,
                       CAST(created_at AS text) AS created_at,
                       CAST(updated_at AS text) AS updated_at
                FROM app_ui.watchlist_generation_rule
                WHERE user_id = :userId ORDER BY updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, i) -> mapRule(rs));
    }

    @Override
    public WatchlistDtos.WatchlistGenerationRuleDto saveWatchlistGenerationRule(WatchlistDtos.SaveWatchlistGenerationRuleRequestDto request) {
        UUID ruleId = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.watchlist_generation_rule
                (rule_id, watchlist_id, user_id, name, exchange_code, rule_type, rule_definition, is_enabled)
                VALUES (:ruleId, :watchlistId, :userId, :name, :exchangeCode, :ruleType, CAST(:ruleDefinition AS jsonb), COALESCE(:isEnabled, true))
                """, paramsRule(ruleId, request.watchlistId(), request.userId(), request.name(), request.exchangeCode(), request.ruleType(), request.ruleDefinition(), request.isEnabled()));
        return getRule(ruleId, request.userId());
    }

    @Override
    public WatchlistDtos.WatchlistGenerationRuleDto updateWatchlistGenerationRule(WatchlistDtos.UpdateWatchlistGenerationRuleRequestDto request) {
        jdbcTemplate.update("""
                UPDATE app_ui.watchlist_generation_rule
                SET watchlist_id = :watchlistId, name = :name, exchange_code = :exchangeCode, rule_type = :ruleType,
                    rule_definition = CAST(:ruleDefinition AS jsonb), is_enabled = COALESCE(:isEnabled, is_enabled), updated_at = now()
                WHERE rule_id = :ruleId AND user_id = :userId
                """, paramsRule(request.ruleId(), request.watchlistId(), request.userId(), request.name(), request.exchangeCode(), request.ruleType(), request.ruleDefinition(), request.isEnabled()));
        return getRule(request.ruleId(), request.userId());
    }

    @Override
    public void deleteWatchlistGenerationRule(UUID ruleId, String userId) {
        jdbcTemplate.update("DELETE FROM app_ui.watchlist_generation_rule WHERE rule_id = :ruleId AND user_id = :userId", new MapSqlParameterSource().addValue("ruleId", ruleId).addValue("userId", userId));
    }

    @Override
    public WatchlistDtos.GenerateWatchlistFromRuleResponseDto generateWatchlistFromRule(UUID ruleId, String userId) {
        WatchlistDtos.WatchlistGenerationRuleDto rule = getRule(ruleId, userId);
        @SuppressWarnings("unchecked") Map<String, Object> definition = rule.ruleDefinition();
        Map<String, Object> filterTree = definition.get("filterTree") instanceof Map<?,?> m ? (Map<String, Object>) m : Map.of("type","group","id","root","operator","AND","enabled",true,"children",List.of());
        int pageSize = definition.get("pageSize") instanceof Number n ? n.intValue() : 500;
        String timeframe = String.valueOf(definition.getOrDefault("defaultTimeframe", "day"));
        String tradeDate = String.valueOf(definition.getOrDefault("tradeDate", ""));
        ScreenerDtos.ScreenerRunRequestDto request = new ScreenerDtos.ScreenerRunRequestDto(
                rule.exchangeCode(), tradeDate, timeframe,
                new ScreenerDtos.ScreenerFilterGroupDto("group", asString(filterTree.get("id"), "root"), asString(filterTree.get("operator"), "AND"), true, (List<Object>) filterTree.getOrDefault("children", List.of())),
                new ScreenerDtos.ScreenerRunRequestDto.Pagination(0, pageSize),
                List.of(new ScreenerDtos.ScreenerRunRequestDto.SortDef("symbol", "asc"))
        );
        ScreenerDtos.ScreenerRunResponseDto results = screenerQueryRepository.run(rule.exchangeCode(), request);
        jdbcTemplate.update("DELETE FROM app_ui.watchlist_item WHERE watchlist_id = :watchlistId AND source_rule_id = :ruleId", new MapSqlParameterSource().addValue("watchlistId", rule.watchlistId()).addValue("ruleId", ruleId));
        List<Long> ids = new ArrayList<>();
        for (ScreenerDtos.ScreenerResultRowDto row : results.rows()) {
            ids.add(row.instrumentId());
            jdbcTemplate.update("""
                    INSERT INTO app_ui.watchlist_item (watchlist_item_id, watchlist_id, instrument_id, source_rule_id, note)
                    VALUES (:itemId, :watchlistId, :instrumentId, :ruleId, :note)
                    ON CONFLICT (watchlist_id, instrument_id) DO UPDATE SET source_rule_id = EXCLUDED.source_rule_id
                    """, new MapSqlParameterSource().addValue("itemId", UUID.randomUUID()).addValue("watchlistId", rule.watchlistId()).addValue("instrumentId", row.instrumentId()).addValue("ruleId", ruleId).addValue("note", "Generated from JSON rule engine"));
        }
        jdbcTemplate.update("UPDATE app_ui.watchlist_generation_rule SET last_generated_at = now(), updated_at = now() WHERE rule_id = :ruleId AND user_id = :userId", new MapSqlParameterSource().addValue("ruleId", ruleId).addValue("userId", userId));
        return new WatchlistDtos.GenerateWatchlistFromRuleResponseDto(ruleId, rule.watchlistId(), ids.size(), ids, java.time.Instant.now().toString());
    }

    @Override
    public void updateAlertRuleStatus(UUID alertRuleId, String userId, String status) {
        jdbcTemplate.update("UPDATE app_ui.alert_rule SET status = :status, updated_at = now() WHERE alert_rule_id = :alertRuleId AND user_id = :userId", new MapSqlParameterSource().addValue("alertRuleId", alertRuleId).addValue("userId", userId).addValue("status", status));
    }

    private WatchlistDtos.WatchlistDefinitionDto getWatchlist(String userId, UUID watchlistId) {
        return jdbcTemplate.queryForObject("""
                SELECT watchlist_id, user_id, name, exchange_code, watchlist_type, rule_engine_type, CAST(created_at AS text) AS created_at, CAST(updated_at AS text) AS updated_at
                FROM app_ui.watchlist_definition WHERE watchlist_id=:watchlistId AND user_id=:userId
                """, new MapSqlParameterSource().addValue("watchlistId", watchlistId).addValue("userId", userId), (rs,i)->mapWatchlist(rs));
    }
    private WatchlistDtos.WatchlistGenerationRuleDto getRule(UUID ruleId, String userId) {
        return jdbcTemplate.queryForObject("""
                SELECT rule_id, watchlist_id, user_id, name, exchange_code, rule_type, rule_definition,
                       is_enabled, CAST(last_generated_at AS text) AS last_generated_at,
                       CAST(created_at AS text) AS created_at,
                       CAST(updated_at AS text) AS updated_at
                FROM app_ui.watchlist_generation_rule
                WHERE rule_id = :ruleId AND user_id = :userId
                """, new MapSqlParameterSource().addValue("ruleId", ruleId).addValue("userId", userId), (rs, i) -> mapRule(rs));
    }
    private MapSqlParameterSource paramsRule(UUID ruleId, UUID watchlistId, String userId, String name, String exchangeCode, String ruleType, Map<String, Object> ruleDefinition, Boolean isEnabled) {
        return new MapSqlParameterSource().addValue("ruleId", ruleId).addValue("watchlistId", watchlistId).addValue("userId", userId).addValue("name", name).addValue("exchangeCode", exchangeCode).addValue("ruleType", ruleType == null ? "JSON_SCREENER_FILTER" : ruleType).addValue("ruleDefinition", toJson(ruleDefinition)).addValue("isEnabled", isEnabled);
    }
    private WatchlistDtos.WatchlistDefinitionDto mapWatchlist(ResultSet rs) throws SQLException { return new WatchlistDtos.WatchlistDefinitionDto((UUID) rs.getObject("watchlist_id"), rs.getString("user_id"), rs.getString("name"), rs.getString("exchange_code"), rs.getString("watchlist_type"), rs.getString("rule_engine_type"), rs.getString("created_at"), rs.getString("updated_at")); }
    private WatchlistDtos.WatchlistItemDto mapWatchlistItem(ResultSet rs) throws SQLException { return new WatchlistDtos.WatchlistItemDto((UUID) rs.getObject("watchlist_item_id"), (UUID) rs.getObject("watchlist_id"), rs.getLong("instrument_id"), rs.getString("symbol"), rs.getString("note"), rs.getString("source_rule_id"), rs.getString("created_at")); }
    private WatchlistDtos.AlertRuleDto mapAlertRule(ResultSet rs) throws SQLException { return new WatchlistDtos.AlertRuleDto((UUID) rs.getObject("alert_rule_id"), rs.getString("user_id"), rs.getString("exchange_code"), rs.getLong("instrument_id"), rs.getString("symbol"), rs.getString("rule_name"), rs.getString("rule_type"), rs.getString("status"), (UUID) rs.getObject("source_watchlist_id"), rs.getString("config_json"), rs.getString("created_at"), rs.getString("updated_at")); }
    private WatchlistDtos.WatchlistGenerationRuleDto mapRule(ResultSet rs) throws SQLException { return new WatchlistDtos.WatchlistGenerationRuleDto((UUID) rs.getObject("rule_id"), (UUID) rs.getObject("watchlist_id"), rs.getString("user_id"), rs.getString("name"), rs.getString("exchange_code"), rs.getString("rule_type"), fromJsonMap(rs.getString("rule_definition")), rs.getBoolean("is_enabled"), rs.getString("last_generated_at"), rs.getString("created_at"), rs.getString("updated_at")); }
    private Map<String, Object> fromJsonMap(String value) { try { return objectMapper.readValue(value, new TypeReference<Map<String, Object>>() {}); } catch (Exception e) { throw new RuntimeException(e); } }
    private String toJson(Object value) { try { return objectMapper.writeValueAsString(value); } catch (JsonProcessingException e) { throw new RuntimeException(e); } }
    private String asString(Object v, String d) { return v == null ? d : String.valueOf(v); }
}
