package com.rathore.stockanalysis.audit.repository;

import com.rathore.stockanalysis.audit.dto.AuditDtos;
import java.util.List;
import java.util.Map;

public interface AuditRepository {
    void recordWatchlistEvent(long watchlistId, String userId, String eventType, String entityType, String entityId,
                              Map<String, Object> beforeJson, Map<String, Object> afterJson);
    void recordAlertEvent(long alertRuleId, String userId, String eventType,
                          Map<String, Object> beforeJson, Map<String, Object> afterJson);
    List<AuditDtos.WatchlistAuditEventDto> getWatchlistTimeline(long watchlistId);
    List<AuditDtos.AlertAuditEventDto> getAlertTimeline(long alertRuleId);
}
