package com.rathore.stockanalysis.audit.dto;

import java.util.List;
import java.util.Map;

public final class AuditDtos {
    private AuditDtos() {}

    public record WatchlistAuditEventDto(
            long auditEventId,
            long watchlistId,
            String userId,
            String eventType,
            String entityType,
            String entityId,
            Map<String, Object> beforeJson,
            Map<String, Object> afterJson,
            String eventTs
    ) {}

    public record AlertAuditEventDto(
            long auditEventId,
            long alertRuleId,
            String userId,
            String eventType,
            Map<String, Object> beforeJson,
            Map<String, Object> afterJson,
            String eventTs
    ) {}

    public record WatchlistAuditTimelineDto(long watchlistId, List<WatchlistAuditEventDto> events) {}
    public record AlertAuditTimelineDto(long alertRuleId, List<AlertAuditEventDto> events) {}
}
