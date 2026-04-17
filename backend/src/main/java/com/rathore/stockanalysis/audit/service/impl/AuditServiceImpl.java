package com.rathore.stockanalysis.audit.service.impl;

import com.rathore.stockanalysis.audit.dto.AuditDtos;
import com.rathore.stockanalysis.audit.repository.AuditRepository;
import com.rathore.stockanalysis.audit.service.AuditService;
import org.springframework.stereotype.Service;

@Service
public class AuditServiceImpl implements AuditService {
    private final AuditRepository auditRepository;

    public AuditServiceImpl(AuditRepository auditRepository) {
        this.auditRepository = auditRepository;
    }

    @Override
    public AuditDtos.WatchlistAuditTimelineDto getWatchlistTimeline(long watchlistId) {
        return new AuditDtos.WatchlistAuditTimelineDto(watchlistId, auditRepository.getWatchlistTimeline(watchlistId));
    }

    @Override
    public AuditDtos.AlertAuditTimelineDto getAlertTimeline(long alertRuleId) {
        return new AuditDtos.AlertAuditTimelineDto(alertRuleId, auditRepository.getAlertTimeline(alertRuleId));
    }
}
