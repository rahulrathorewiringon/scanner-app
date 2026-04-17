package com.rathore.stockanalysis.audit;

import com.rathore.stockanalysis.audit.repository.AuditRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class AuditRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired AuditRepository auditRepository;

    @Test
    void shouldRecordAndReadWatchlistAuditEvents() {
        auditRepository.recordWatchlistEvent(10L, "owner", "ITEM_ADDED", "WATCHLIST_ITEM", "100",
                Map.of("count", 1), Map.of("count", 2));
        var events = auditRepository.getWatchlistTimeline(10L);
        assertEquals(1, events.size());
        assertEquals("ITEM_ADDED", events.get(0).eventType());
    }

    @Test
    void shouldRecordAndReadAlertAuditEvents() {
        auditRepository.recordAlertEvent(20L, "owner", "RULE_UPDATED",
                Map.of("status", "ACTIVE"), Map.of("status", "PAUSED"));
        var events = auditRepository.getAlertTimeline(20L);
        assertEquals(1, events.size());
        assertEquals("RULE_UPDATED", events.get(0).eventType());
    }
}
