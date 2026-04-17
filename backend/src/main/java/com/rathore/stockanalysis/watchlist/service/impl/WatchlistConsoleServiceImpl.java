package com.rathore.stockanalysis.watchlist.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rathore.stockanalysis.audit.repository.AuditRepository;
import com.rathore.stockanalysis.watchlist.dto.WatchlistDtos;
import com.rathore.stockanalysis.watchlist.repository.WatchlistConsoleRepository;
import com.rathore.stockanalysis.watchlist.service.WatchlistConsoleService;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class WatchlistConsoleServiceImpl implements WatchlistConsoleService {
    private final WatchlistConsoleRepository repository;
    private final AuditRepository auditRepository;
    private final ObjectMapper objectMapper;
    public WatchlistConsoleServiceImpl(WatchlistConsoleRepository repository, AuditRepository auditRepository, ObjectMapper objectMapper) { this.repository = repository; this.auditRepository = auditRepository; this.objectMapper = objectMapper; }
    private long key(UUID id){ return Math.abs(id.getMostSignificantBits()); }
    @SuppressWarnings("unchecked") private Map<String,Object> toMap(Object value){ return value == null ? null : objectMapper.convertValue(value, LinkedHashMap.class); }
    public List<WatchlistDtos.WatchlistDefinitionDto> listWatchlists(String userId){ return repository.listWatchlists(userId); }
    public WatchlistDtos.WatchlistDefinitionDto createWatchlist(WatchlistDtos.CreateWatchlistRequestDto request){ var created=repository.createWatchlist(request); auditRepository.recordWatchlistEvent(key(created.watchlistId()), request.userId(), "WATCHLIST_CREATED", "WATCHLIST", created.watchlistId().toString(), null, toMap(created)); return created; }
    public WatchlistDtos.WatchlistDefinitionDto updateWatchlist(WatchlistDtos.UpdateWatchlistRequestDto request){ var before=repository.getWatchlistDetail(request.userId(), request.watchlistId()); var updated=repository.updateWatchlist(request); auditRepository.recordWatchlistEvent(key(request.watchlistId()), request.userId(), "WATCHLIST_UPDATED", "WATCHLIST", request.watchlistId().toString(), toMap(before.watchlist()), toMap(updated)); return updated; }
    public void deleteWatchlist(UUID watchlistId, String userId){ var before=repository.getWatchlistDetail(userId, watchlistId); repository.deleteWatchlist(watchlistId, userId); auditRepository.recordWatchlistEvent(key(watchlistId), userId, "WATCHLIST_DELETED", "WATCHLIST", watchlistId.toString(), toMap(before.watchlist()), null); }
    public WatchlistDtos.WatchlistDetailDto getWatchlistDetail(String userId, UUID watchlistId){ return repository.getWatchlistDetail(userId, watchlistId); }
    public List<WatchlistDtos.WatchlistItemDto> listWatchlistItems(String userId, UUID watchlistId){ return repository.listWatchlistItems(userId, watchlistId); }
    public WatchlistDtos.WatchlistItemDto addWatchlistItem(UUID watchlistId, WatchlistDtos.CreateWatchlistItemRequestDto request){ var created=repository.addWatchlistItem(watchlistId, request); auditRepository.recordWatchlistEvent(key(watchlistId), request.userId(), "WATCHLIST_ITEM_ADDED", "WATCHLIST_ITEM", created.watchlistItemId().toString(), null, toMap(created)); return created; }
    public WatchlistDtos.WatchlistItemDto updateWatchlistItem(UUID watchlistId, WatchlistDtos.UpdateWatchlistItemRequestDto request){ var before=repository.listWatchlistItems(request.userId(), watchlistId).stream().filter(i -> i.watchlistItemId().equals(request.watchlistItemId())).findFirst().orElse(null); var updated=repository.updateWatchlistItem(watchlistId, request); auditRepository.recordWatchlistEvent(key(watchlistId), request.userId(), "WATCHLIST_ITEM_UPDATED", "WATCHLIST_ITEM", request.watchlistItemId().toString(), toMap(before), toMap(updated)); return updated; }
    public void deleteWatchlistItem(UUID watchlistId, UUID watchlistItemId, String userId){ var before=repository.listWatchlistItems(userId, watchlistId).stream().filter(i -> i.watchlistItemId().equals(watchlistItemId)).findFirst().orElse(null); repository.deleteWatchlistItem(watchlistId, watchlistItemId, userId); auditRepository.recordWatchlistEvent(key(watchlistId), userId, "WATCHLIST_ITEM_DELETED", "WATCHLIST_ITEM", watchlistItemId.toString(), toMap(before), null); }
    public List<WatchlistDtos.AlertRuleDto> listAlertRules(String userId){ return repository.listAlertRules(userId); }
    public WatchlistDtos.AlertRuleDto getAlertRuleDetail(String userId, UUID alertRuleId){ return repository.getAlertRuleDetail(userId, alertRuleId); }
    public WatchlistDtos.AlertRuleDto updateAlertRule(WatchlistDtos.UpdateAlertRuleRequestDto request){ var before=repository.getAlertRuleDetail(request.userId(), request.alertRuleId()); var updated=repository.updateAlertRule(request); auditRepository.recordAlertEvent(key(request.alertRuleId()), request.userId(), "ALERT_RULE_UPDATED", toMap(before), toMap(updated)); return updated; }
    public void deleteAlertRule(UUID alertRuleId, String userId){ var before=repository.getAlertRuleDetail(userId, alertRuleId); repository.deleteAlertRule(alertRuleId, userId); auditRepository.recordAlertEvent(key(alertRuleId), userId, "ALERT_RULE_DELETED", toMap(before), null); }
    public void updateAlertRuleStatus(UUID alertRuleId, String userId, String status){ var before=repository.getAlertRuleDetail(userId, alertRuleId); repository.updateAlertRuleStatus(alertRuleId, userId, status); var after=repository.getAlertRuleDetail(userId, alertRuleId); auditRepository.recordAlertEvent(key(alertRuleId), userId, "ALERT_RULE_STATUS_UPDATED", toMap(before), toMap(after)); }
    public List<WatchlistDtos.WatchlistGenerationRuleDto> listRules(String userId){ return repository.listWatchlistGenerationRules(userId); }
    public WatchlistDtos.WatchlistGenerationRuleDto saveRule(WatchlistDtos.SaveWatchlistGenerationRuleRequestDto request){ return repository.saveWatchlistGenerationRule(request); }
    public WatchlistDtos.WatchlistGenerationRuleDto updateRule(WatchlistDtos.UpdateWatchlistGenerationRuleRequestDto request){ return repository.updateWatchlistGenerationRule(request); }
    public void deleteRule(UUID ruleId, String userId){ repository.deleteWatchlistGenerationRule(ruleId, userId); }
    public WatchlistDtos.GenerateWatchlistFromRuleResponseDto generateRule(UUID ruleId, String userId){ return repository.generateWatchlistFromRule(ruleId, userId); }
}
