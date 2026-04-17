package com.rathore.stockanalysis.audit.repository.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rathore.stockanalysis.audit.dto.AuditDtos;
import com.rathore.stockanalysis.audit.repository.AuditRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AuditRepositoryImpl implements AuditRepository {
    private final JdbcTemplate jdbcTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public AuditRepositoryImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void recordWatchlistEvent(long watchlistId, String userId, String eventType, String entityType, String entityId,
                                     Map<String, Object> beforeJson, Map<String, Object> afterJson) {
        jdbcTemplate.update(
                "insert into app_ui.watchlist_audit_event (watchlist_id, user_id, event_type, entity_type, entity_id, before_json, after_json) values (?, ?, ?, ?, ?, cast(? as jsonb), cast(? as jsonb))",
                watchlistId, userId, eventType, entityType, entityId, toJson(beforeJson), toJson(afterJson)
        );
    }

    @Override
    public void recordAlertEvent(long alertRuleId, String userId, String eventType, Map<String, Object> beforeJson, Map<String, Object> afterJson) {
        jdbcTemplate.update(
                "insert into app_ui.alert_rule_audit_event (alert_rule_id, user_id, event_type, before_json, after_json) values (?, ?, ?, cast(? as jsonb), cast(? as jsonb))",
                alertRuleId, userId, eventType, toJson(beforeJson), toJson(afterJson)
        );
    }

    @Override
    public List<AuditDtos.WatchlistAuditEventDto> getWatchlistTimeline(long watchlistId) {
        return jdbcTemplate.query(
                "select * from app_ui.watchlist_audit_event where watchlist_id = ? order by event_ts desc, audit_event_id desc",
                (rs, rn) -> new AuditDtos.WatchlistAuditEventDto(
                        rs.getLong("audit_event_id"),
                        rs.getLong("watchlist_id"),
                        rs.getString("user_id"),
                        rs.getString("event_type"),
                        rs.getString("entity_type"),
                        rs.getString("entity_id"),
                        fromJson(rs.getString("before_json")),
                        fromJson(rs.getString("after_json")),
                        rs.getTimestamp("event_ts").toInstant().toString()
                ),
                watchlistId
        );
    }

    @Override
    public List<AuditDtos.AlertAuditEventDto> getAlertTimeline(long alertRuleId) {
        return jdbcTemplate.query(
                "select * from app_ui.alert_rule_audit_event where alert_rule_id = ? order by event_ts desc, audit_event_id desc",
                (rs, rn) -> new AuditDtos.AlertAuditEventDto(
                        rs.getLong("audit_event_id"),
                        rs.getLong("alert_rule_id"),
                        rs.getString("user_id"),
                        rs.getString("event_type"),
                        fromJson(rs.getString("before_json")),
                        fromJson(rs.getString("after_json")),
                        rs.getTimestamp("event_ts").toInstant().toString()
                ),
                alertRuleId
        );
    }

    private String toJson(Map<String, Object> value) {
        try {
            return value == null ? null : objectMapper.writeValueAsString(value);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private Map<String, Object> fromJson(String raw) {
        try {
            return raw == null ? null : objectMapper.readValue(raw, new TypeReference<>() {});
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
