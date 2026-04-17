package com.rathore.stockanalysis.preference.repository.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rathore.stockanalysis.preference.dto.*;
import com.rathore.stockanalysis.preference.repository.UserPreferenceRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

@Repository
public class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ObjectMapper objectMapper;

    public UserPreferenceRepositoryImpl(NamedParameterJdbcTemplate jdbcTemplate, ObjectMapper objectMapper) {
        this.jdbcTemplate = jdbcTemplate;
        this.objectMapper = objectMapper;
    }

    @Override
    public List<SavedScreenerDefinitionDto> listSavedScreeners(String userId) {
        return jdbcTemplate.query("""
                SELECT screener_id, user_id, name, exchange_code, trade_date, default_timeframe, filter_tree, sort_spec, page_size, created_at, updated_at
                FROM app_ui.saved_screener_definition
                WHERE user_id = :userId
                ORDER BY updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, n) -> mapSavedScreener(rs));
    }


    @Override
    public List<SavedScreenerDefinitionDto> listSharedScreeners(String userId) {
        return jdbcTemplate.query("""
                SELECT d.screener_id, d.user_id, d.name, d.exchange_code, d.trade_date, d.default_timeframe, d.filter_tree, d.sort_spec, d.page_size, d.created_at, d.updated_at
                FROM app_ui.saved_screener_definition d
                JOIN app_ui.saved_screener_share s ON s.screener_id = d.screener_id
                WHERE s.shared_with_user_id = :userId
                ORDER BY d.updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, n) -> mapSavedScreener(rs));
    }

    @Override
    public SavedScreenerDefinitionDto saveScreener(SaveScreenerRequestDto request) {
        UUID id = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.saved_screener_definition
                (screener_id, user_id, name, exchange_code, trade_date, default_timeframe, filter_tree, sort_spec, page_size)
                VALUES (:screenerId, :userId, :name, :exchangeCode, :tradeDate, :defaultTimeframe, CAST(:filterTree AS jsonb), CAST(:sortSpec AS jsonb), :pageSize)
                """, screenerParams(id, request.userId(), request.name(), request.exchangeCode(), request.tradeDate(), request.defaultTimeframe(), request.filterTree(), request.sortSpec(), request.pageSize()));
        return getSavedScreener(id, request.userId());
    }

    @Override
    public SavedScreenerDefinitionDto updateScreener(UpdateScreenerRequestDto request) {
        jdbcTemplate.update("""
                UPDATE app_ui.saved_screener_definition
                SET name = :name,
                    exchange_code = :exchangeCode,
                    trade_date = :tradeDate,
                    default_timeframe = :defaultTimeframe,
                    filter_tree = CAST(:filterTree AS jsonb),
                    sort_spec = CAST(:sortSpec AS jsonb),
                    page_size = :pageSize,
                    updated_at = now()
                WHERE screener_id = :screenerId AND user_id = :userId
                """, screenerParams(request.screenerId(), request.userId(), request.name(), request.exchangeCode(), request.tradeDate(), request.defaultTimeframe(), request.filterTree(), request.sortSpec(), request.pageSize()));
        return getSavedScreener(request.screenerId(), request.userId());
    }

    @Override
    public void deleteSavedScreener(UUID screenerId, String userId) {
        jdbcTemplate.update("DELETE FROM app_ui.saved_screener_definition WHERE screener_id = :id AND user_id = :userId",
                new MapSqlParameterSource().addValue("id", screenerId).addValue("userId", userId));
    }

    @Override
    public List<SavedScreenerTagDto> listScreenerTags(UUID screenerId, String userId) {
        assertScreenerOwner(screenerId, userId);
        return jdbcTemplate.query("""
                SELECT screener_id, tag, CAST(created_at AS text) AS created_at
                FROM app_ui.saved_screener_tag
                WHERE screener_id = :screenerId
                ORDER BY tag ASC
                """, new MapSqlParameterSource("screenerId", screenerId), (rs, n) -> new SavedScreenerTagDto((UUID) rs.getObject("screener_id"), rs.getString("tag"), rs.getString("created_at")));
    }

    @Override
    public List<SavedScreenerTagDto> replaceScreenerTags(UUID screenerId, String userId, List<String> tags) {
        assertScreenerOwner(screenerId, userId);
        jdbcTemplate.update("DELETE FROM app_ui.saved_screener_tag WHERE screener_id = :screenerId", new MapSqlParameterSource("screenerId", screenerId));
        for (String tag : new LinkedHashSet<>(tags)) {
            if (tag == null || tag.isBlank()) continue;
            jdbcTemplate.update("INSERT INTO app_ui.saved_screener_tag (screener_id, tag) VALUES (:screenerId, :tag)", new MapSqlParameterSource().addValue("screenerId", screenerId).addValue("tag", tag.trim()));
        }
        return listScreenerTags(screenerId, userId);
    }

    @Override
    public List<SavedScreenerShareDto> listScreenerShares(UUID screenerId, String ownerUserId) {
        assertScreenerOwner(screenerId, ownerUserId);
        return jdbcTemplate.query("""
                SELECT share_id, screener_id, owner_user_id, shared_with_user_id, permission, CAST(created_at AS text) AS created_at
                FROM app_ui.saved_screener_share
                WHERE screener_id = :screenerId AND owner_user_id = :ownerUserId
                ORDER BY created_at DESC
                """, new MapSqlParameterSource().addValue("screenerId", screenerId).addValue("ownerUserId", ownerUserId),
                (rs, n) -> new SavedScreenerShareDto((UUID) rs.getObject("share_id"), (UUID) rs.getObject("screener_id"), rs.getString("owner_user_id"), rs.getString("shared_with_user_id"), rs.getString("permission"), rs.getString("created_at")));
    }

    @Override
    public SavedScreenerShareDto saveScreenerShare(SaveScreenerShareRequestDto request) {
        assertScreenerOwner(request.screenerId(), request.ownerUserId());
        UUID shareId = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.saved_screener_share (share_id, screener_id, owner_user_id, shared_with_user_id, permission)
                VALUES (:shareId, :screenerId, :ownerUserId, :sharedWithUserId, :permission)
                ON CONFLICT (screener_id, shared_with_user_id)
                DO UPDATE SET permission = EXCLUDED.permission
                """, new MapSqlParameterSource()
                .addValue("shareId", shareId)
                .addValue("screenerId", request.screenerId())
                .addValue("ownerUserId", request.ownerUserId())
                .addValue("sharedWithUserId", request.sharedWithUserId())
                .addValue("permission", request.permission() == null ? "VIEW" : request.permission()));
        return jdbcTemplate.queryForObject("""
                SELECT share_id, screener_id, owner_user_id, shared_with_user_id, permission, CAST(created_at AS text) AS created_at
                FROM app_ui.saved_screener_share
                WHERE screener_id = :screenerId AND shared_with_user_id = :sharedWithUserId
                """, new MapSqlParameterSource().addValue("screenerId", request.screenerId()).addValue("sharedWithUserId", request.sharedWithUserId()),
                (rs, n) -> new SavedScreenerShareDto((UUID) rs.getObject("share_id"), (UUID) rs.getObject("screener_id"), rs.getString("owner_user_id"), rs.getString("shared_with_user_id"), rs.getString("permission"), rs.getString("created_at")));
    }

    @Override
    public SavedScreenerShareDto updateScreenerSharePermission(SaveScreenerShareRequestDto request) {
        return saveScreenerShare(request);
    }

    @Override
    public void deleteScreenerShare(UUID screenerId, String ownerUserId, String sharedWithUserId) {
        assertScreenerOwner(screenerId, ownerUserId);
        jdbcTemplate.update("DELETE FROM app_ui.saved_screener_share WHERE screener_id = :screenerId AND owner_user_id = :ownerUserId AND shared_with_user_id = :sharedWithUserId",
                new MapSqlParameterSource().addValue("screenerId", screenerId).addValue("ownerUserId", ownerUserId).addValue("sharedWithUserId", sharedWithUserId));
    }

    @Override
    public List<WorkspaceLayoutPresetDto> listLayoutPresets(String userId) {
        return jdbcTemplate.query("""
                SELECT preset_id, user_id, name, exchange_code, layout_json, is_default, is_favorite, created_at, updated_at
                FROM app_ui.workspace_layout_preset
                WHERE user_id = :userId
                ORDER BY is_default DESC, is_favorite DESC, updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, n) -> mapLayoutPreset(rs));
    }

    @Override
    public WorkspaceLayoutPresetDto saveLayoutPreset(SaveWorkspaceLayoutPresetRequestDto request) {
        UUID id = UUID.randomUUID();
        if (Boolean.TRUE.equals(request.isDefault())) clearDefault(request.userId());
        jdbcTemplate.update("""
                INSERT INTO app_ui.workspace_layout_preset
                (preset_id, user_id, name, exchange_code, layout_json, is_default, is_favorite)
                VALUES (:presetId, :userId, :name, :exchangeCode, CAST(:layoutJson AS jsonb), :isDefault, :isFavorite)
                """, presetParams(id, request.userId(), request.name(), request.exchangeCode(), request.layoutJson(), request.isDefault(), request.isFavorite()));
        return getLayoutPreset(id, request.userId());
    }

    @Override
    public WorkspaceLayoutPresetDto updateLayoutPreset(UpdateWorkspaceLayoutPresetRequestDto request) {
        if (Boolean.TRUE.equals(request.isDefault())) clearDefault(request.userId());
        jdbcTemplate.update("""
                UPDATE app_ui.workspace_layout_preset
                SET name = :name,
                    exchange_code = :exchangeCode,
                    layout_json = CAST(:layoutJson AS jsonb),
                    is_default = COALESCE(:isDefault, is_default),
                    is_favorite = COALESCE(:isFavorite, is_favorite),
                    updated_at = now()
                WHERE preset_id = :presetId AND user_id = :userId
                """, presetParams(request.presetId(), request.userId(), request.name(), request.exchangeCode(), request.layoutJson(), request.isDefault(), request.isFavorite()));
        return getLayoutPreset(request.presetId(), request.userId());
    }

    @Override
    public void markDefaultLayoutPreset(UUID presetId, String userId) {
        clearDefault(userId);
        jdbcTemplate.update("UPDATE app_ui.workspace_layout_preset SET is_default = true, updated_at = now() WHERE preset_id = :presetId AND user_id = :userId",
                new MapSqlParameterSource().addValue("presetId", presetId).addValue("userId", userId));
    }

    @Override
    public void markFavoriteLayoutPreset(UUID presetId, String userId, boolean favorite) {
        jdbcTemplate.update("UPDATE app_ui.workspace_layout_preset SET is_favorite = :favorite, updated_at = now() WHERE preset_id = :presetId AND user_id = :userId",
                new MapSqlParameterSource().addValue("presetId", presetId).addValue("userId", userId).addValue("favorite", favorite));
    }

    @Override
    public void deleteLayoutPreset(UUID presetId, String userId) {
        jdbcTemplate.update("DELETE FROM app_ui.workspace_layout_preset WHERE preset_id = :id AND user_id = :userId",
                new MapSqlParameterSource().addValue("id", presetId).addValue("userId", userId));
    }

    @Override
    public List<WorkspaceLayoutPresetDto> listSharedLayoutPresets(String userId) {
        return jdbcTemplate.query("""
                SELECT p.preset_id, p.user_id, p.name, p.exchange_code, p.layout_json, p.is_default, p.is_favorite, p.created_at, p.updated_at
                FROM app_ui.workspace_layout_preset p
                JOIN app_ui.workspace_layout_preset_share s ON s.preset_id = p.preset_id
                WHERE s.shared_with_user_id = :userId
                ORDER BY p.updated_at DESC
                """, new MapSqlParameterSource("userId", userId), (rs, n) -> mapLayoutPreset(rs));
    }

    @Override
    public List<WorkspaceLayoutPresetShareDto> listLayoutPresetShares(UUID presetId, String ownerUserId) {
        return jdbcTemplate.query("""
                SELECT share_id, preset_id, owner_user_id, shared_with_user_id, permission, CAST(created_at AS text) AS created_at
                FROM app_ui.workspace_layout_preset_share
                WHERE preset_id = :presetId AND owner_user_id = :ownerUserId
                ORDER BY created_at DESC
                """, new MapSqlParameterSource().addValue("presetId", presetId).addValue("ownerUserId", ownerUserId),
                (rs, n) -> new WorkspaceLayoutPresetShareDto((UUID) rs.getObject("share_id"), (UUID) rs.getObject("preset_id"), rs.getString("owner_user_id"), rs.getString("shared_with_user_id"), rs.getString("permission"), rs.getString("created_at")));
    }

    @Override
    public WorkspaceLayoutPresetShareDto saveLayoutPresetShare(SaveWorkspaceLayoutPresetShareRequestDto request) {
        UUID shareId = UUID.randomUUID();
        jdbcTemplate.update("""
                INSERT INTO app_ui.workspace_layout_preset_share (share_id, preset_id, owner_user_id, shared_with_user_id, permission)
                VALUES (:shareId, :presetId, :ownerUserId, :sharedWithUserId, :permission)
                ON CONFLICT (preset_id, shared_with_user_id)
                DO UPDATE SET permission = EXCLUDED.permission
                """, new MapSqlParameterSource()
                .addValue("shareId", shareId)
                .addValue("presetId", request.presetId())
                .addValue("ownerUserId", request.ownerUserId())
                .addValue("sharedWithUserId", request.sharedWithUserId())
                .addValue("permission", request.permission() == null ? "VIEW" : request.permission()));
        return jdbcTemplate.queryForObject("""
                SELECT share_id, preset_id, owner_user_id, shared_with_user_id, permission, CAST(created_at AS text) AS created_at
                FROM app_ui.workspace_layout_preset_share
                WHERE preset_id = :presetId AND shared_with_user_id = :sharedWithUserId
                """, new MapSqlParameterSource().addValue("presetId", request.presetId()).addValue("sharedWithUserId", request.sharedWithUserId()),
                (rs, n) -> new WorkspaceLayoutPresetShareDto((UUID) rs.getObject("share_id"), (UUID) rs.getObject("preset_id"), rs.getString("owner_user_id"), rs.getString("shared_with_user_id"), rs.getString("permission"), rs.getString("created_at")));
    }

    @Override
    public WorkspaceLayoutPresetShareDto updateLayoutPresetSharePermission(SaveWorkspaceLayoutPresetShareRequestDto request) {
        return saveLayoutPresetShare(request);
    }

    @Override
    public void deleteLayoutPresetShare(UUID presetId, String ownerUserId, String sharedWithUserId) {
        jdbcTemplate.update("DELETE FROM app_ui.workspace_layout_preset_share WHERE preset_id = :presetId AND owner_user_id = :ownerUserId AND shared_with_user_id = :sharedWithUserId",
                new MapSqlParameterSource().addValue("presetId", presetId).addValue("ownerUserId", ownerUserId).addValue("sharedWithUserId", sharedWithUserId));
    }

    @Override
    public ScreenerBulkActionResponseDto applyBulkAction(ScreenerBulkActionRequestDto request) {
        UUID actionId = UUID.randomUUID();
        int acceptedCount = request.instrumentIds() == null ? 0 : request.instrumentIds().size();
        String entityType = null;
        String entityId = null;
        jdbcTemplate.update("""
                INSERT INTO app_ui.screener_bulk_action_audit
                (action_id, user_id, action_type, instrument_ids, payload, accepted_count)
                VALUES (:actionId, :userId, :actionType, CAST(:instrumentIds AS jsonb), CAST(:payload AS jsonb), :acceptedCount)
                """, new MapSqlParameterSource()
                .addValue("actionId", actionId)
                .addValue("userId", request.userId())
                .addValue("actionType", request.actionType())
                .addValue("instrumentIds", toJson(request.instrumentIds()))
                .addValue("payload", toJson(request.payload()))
                .addValue("acceptedCount", acceptedCount));

        if ("ADD_TO_WATCHLIST".equalsIgnoreCase(request.actionType())) {
            UUID watchlistId = ensureWatchlist(request.userId(), stringPayload(request.payload(), "watchlistName", "Default Watchlist"), stringPayload(request.payload(), "exchangeCode", "NSE"), false, null);
            for (Long instrumentId : request.instrumentIds()) {
                jdbcTemplate.update("""
                        INSERT INTO app_ui.watchlist_item (watchlist_item_id, watchlist_id, instrument_id, source_action_id, note)
                        VALUES (:id, :watchlistId, :instrumentId, :actionId, :note)
                        ON CONFLICT (watchlist_id, instrument_id) DO NOTHING
                        """, new MapSqlParameterSource()
                        .addValue("id", UUID.randomUUID())
                        .addValue("watchlistId", watchlistId)
                        .addValue("instrumentId", instrumentId)
                        .addValue("actionId", actionId)
                        .addValue("note", stringPayload(request.payload(), "note", null)));
            }
            entityType = "WATCHLIST";
            entityId = watchlistId.toString();
        } else if ("CREATE_ALERT".equalsIgnoreCase(request.actionType())) {
            String exchangeCode = stringPayload(request.payload(), "exchangeCode", "NSE");
            String ruleName = stringPayload(request.payload(), "ruleName", "Bulk Alert Rule");
            String ruleType = stringPayload(request.payload(), "ruleType", "PRICE_ACTION");
            String sourceWatchlistId = stringPayload(request.payload(), "sourceWatchlistId", null);
            for (Long instrumentId : request.instrumentIds()) {
                UUID alertRuleId = UUID.randomUUID();
                jdbcTemplate.update("""
                        INSERT INTO app_ui.alert_rule (alert_rule_id, user_id, exchange_code, instrument_id, rule_name, rule_type, source_action_id, source_watchlist_id, config_json)
                        VALUES (:alertRuleId, :userId, :exchangeCode, :instrumentId, :ruleName, :ruleType, :actionId, :sourceWatchlistId, CAST(:configJson AS jsonb))
                        """, new MapSqlParameterSource()
                        .addValue("alertRuleId", alertRuleId)
                        .addValue("userId", request.userId())
                        .addValue("exchangeCode", exchangeCode)
                        .addValue("instrumentId", instrumentId)
                        .addValue("ruleName", ruleName)
                        .addValue("ruleType", ruleType)
                        .addValue("actionId", actionId)
                        .addValue("sourceWatchlistId", sourceWatchlistId == null ? null : UUID.fromString(sourceWatchlistId))
                        .addValue("configJson", toJson(request.payload())));
                entityId = alertRuleId.toString();
            }
            entityType = "ALERT_RULE";
        } else if ("EXPORT_SELECTION".equalsIgnoreCase(request.actionType())) {
            entityType = "EXPORT";
            entityId = actionId.toString();
        }
        return new ScreenerBulkActionResponseDto(actionId, request.actionType(), acceptedCount, "Accepted " + acceptedCount + " instruments for action " + request.actionType(), entityType, entityId);
    }

    public UUID ensureWatchlist(String userId, String name, String exchangeCode, boolean generated, String ruleEngineType) {
        List<UUID> existing = jdbcTemplate.query("SELECT watchlist_id FROM app_ui.watchlist_definition WHERE user_id = :userId AND name = :name", new MapSqlParameterSource().addValue("userId", userId).addValue("name", name), (rs, n) -> rs.getObject(1, UUID.class));
        if (!existing.isEmpty()) return existing.get(0);
        UUID watchlistId = UUID.randomUUID();
        jdbcTemplate.update("INSERT INTO app_ui.watchlist_definition (watchlist_id, user_id, name, exchange_code, watchlist_type, rule_engine_type) VALUES (:id, :userId, :name, :exchangeCode, :watchlistType, :ruleEngineType)", new MapSqlParameterSource().addValue("id", watchlistId).addValue("userId", userId).addValue("name", name).addValue("exchangeCode", exchangeCode).addValue("watchlistType", generated ? "RULE_GENERATED" : "MANUAL").addValue("ruleEngineType", ruleEngineType));
        return watchlistId;
    }

    private void clearDefault(String userId) {
        jdbcTemplate.update("UPDATE app_ui.workspace_layout_preset SET is_default = false WHERE user_id = :userId", new MapSqlParameterSource("userId", userId));
    }

    private void assertScreenerOwner(UUID screenerId, String userId) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM app_ui.saved_screener_definition WHERE screener_id = :screenerId AND user_id = :userId", new MapSqlParameterSource().addValue("screenerId", screenerId).addValue("userId", userId), Integer.class);
        if (count == null || count == 0) throw new IllegalArgumentException("Saved screener not found for user");
    }

    private SavedScreenerDefinitionDto getSavedScreener(UUID screenerId, String userId) {
        return jdbcTemplate.queryForObject("SELECT screener_id, user_id, name, exchange_code, trade_date, default_timeframe, filter_tree, sort_spec, page_size, created_at, updated_at FROM app_ui.saved_screener_definition WHERE screener_id = :id AND user_id = :userId", new MapSqlParameterSource().addValue("id", screenerId).addValue("userId", userId), (rs, n) -> mapSavedScreener(rs));
    }

    private WorkspaceLayoutPresetDto getLayoutPreset(UUID presetId, String userId) {
        return jdbcTemplate.queryForObject("SELECT preset_id, user_id, name, exchange_code, layout_json, is_default, is_favorite, created_at, updated_at FROM app_ui.workspace_layout_preset WHERE preset_id = :id AND user_id = :userId", new MapSqlParameterSource().addValue("id", presetId).addValue("userId", userId), (rs, n) -> mapLayoutPreset(rs));
    }

    private MapSqlParameterSource screenerParams(UUID id, String userId, String name, String exchangeCode, String tradeDate, String defaultTimeframe, Map<String, Object> filterTree, Object sortSpec, int pageSize) {
        return new MapSqlParameterSource().addValue("screenerId", id).addValue("userId", userId).addValue("name", name).addValue("exchangeCode", exchangeCode).addValue("tradeDate", LocalDate.parse(tradeDate)).addValue("defaultTimeframe", defaultTimeframe).addValue("filterTree", toJson(filterTree)).addValue("sortSpec", toJson(sortSpec)).addValue("pageSize", pageSize);
    }

    private MapSqlParameterSource presetParams(UUID id, String userId, String name, String exchangeCode, Map<String, Object> layoutJson, Boolean isDefault, Boolean isFavorite) {
        return new MapSqlParameterSource().addValue("presetId", id).addValue("userId", userId).addValue("name", name).addValue("exchangeCode", exchangeCode).addValue("layoutJson", toJson(layoutJson)).addValue("isDefault", Boolean.TRUE.equals(isDefault)).addValue("isFavorite", Boolean.TRUE.equals(isFavorite));
    }

    private SavedScreenerDefinitionDto mapSavedScreener(ResultSet rs) throws SQLException {
        return new SavedScreenerDefinitionDto(rs.getObject("screener_id", UUID.class), rs.getString("user_id"), rs.getString("name"), rs.getString("exchange_code"), String.valueOf(rs.getDate("trade_date").toLocalDate()), rs.getString("default_timeframe"), fromJsonMap(rs.getString("filter_tree")), fromJson(rs.getString("sort_spec")), rs.getInt("page_size"), rs.getTimestamp("created_at").toInstant().toString(), rs.getTimestamp("updated_at").toInstant().toString());
    }

    private WorkspaceLayoutPresetDto mapLayoutPreset(ResultSet rs) throws SQLException {
        return new WorkspaceLayoutPresetDto(rs.getObject("preset_id", UUID.class), rs.getString("user_id"), rs.getString("name"), rs.getString("exchange_code"), fromJsonMap(rs.getString("layout_json")), rs.getBoolean("is_default"), rs.getBoolean("is_favorite"), rs.getTimestamp("created_at").toInstant().toString(), rs.getTimestamp("updated_at").toInstant().toString());
    }

    private String toJson(Object value) { try { return objectMapper.writeValueAsString(value); } catch (JsonProcessingException e) { throw new RuntimeException(e); } }
    private Map<String, Object> fromJsonMap(String value) { try { return objectMapper.readValue(value, new TypeReference<Map<String, Object>>() {}); } catch (Exception e) { throw new RuntimeException(e); } }
    private Object fromJson(String value) { try { return objectMapper.readValue(value, Object.class); } catch (Exception e) { throw new RuntimeException(e); } }
    private String stringPayload(Map<String, Object> payload, String key, String fallback) { if (payload == null) return fallback; Object value = payload.get(key); return value == null ? fallback : String.valueOf(value); }
}
