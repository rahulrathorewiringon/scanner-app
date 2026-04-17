package com.rathore.stockanalysis.audit.service;

import com.rathore.stockanalysis.audit.dto.AuditDtos;

public interface AuditService {
    AuditDtos.WatchlistAuditTimelineDto getWatchlistTimeline(long watchlistId);
    AuditDtos.AlertAuditTimelineDto getAlertTimeline(long alertRuleId);
}
