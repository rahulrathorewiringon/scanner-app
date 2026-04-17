package com.rathore.stockanalysis.audit.controller;

import com.rathore.stockanalysis.audit.dto.AuditDtos;
import com.rathore.stockanalysis.audit.service.AuditService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/audit")
public class AuditController { private final AuditService auditService; public AuditController(AuditService auditService){ this.auditService=auditService; } @GetMapping("/watchlists/{watchlistId}") public AuditDtos.WatchlistAuditTimelineDto getWatchlistTimeline(@PathVariable long watchlistId){ return auditService.getWatchlistTimeline(watchlistId);} @GetMapping("/alerts/{alertRuleId}") public AuditDtos.AlertAuditTimelineDto getAlertTimeline(@PathVariable long alertRuleId){ return auditService.getAlertTimeline(alertRuleId);} }
