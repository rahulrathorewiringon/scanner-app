package com.rathore.stockanalysis.watchlist.service;

import com.rathore.stockanalysis.watchlist.dto.WatchlistDtos;

import java.util.List;
import java.util.UUID;

public interface WatchlistConsoleService {
    List<WatchlistDtos.WatchlistDefinitionDto> listWatchlists(String userId);
    WatchlistDtos.WatchlistDefinitionDto createWatchlist(WatchlistDtos.CreateWatchlistRequestDto request);
    WatchlistDtos.WatchlistDefinitionDto updateWatchlist(WatchlistDtos.UpdateWatchlistRequestDto request);
    void deleteWatchlist(UUID watchlistId, String userId);
    WatchlistDtos.WatchlistDetailDto getWatchlistDetail(String userId, UUID watchlistId);
    List<WatchlistDtos.WatchlistItemDto> listWatchlistItems(String userId, UUID watchlistId);
    WatchlistDtos.WatchlistItemDto addWatchlistItem(UUID watchlistId, WatchlistDtos.CreateWatchlistItemRequestDto request);
    WatchlistDtos.WatchlistItemDto updateWatchlistItem(UUID watchlistId, WatchlistDtos.UpdateWatchlistItemRequestDto request);
    void deleteWatchlistItem(UUID watchlistId, UUID watchlistItemId, String userId);
    List<WatchlistDtos.AlertRuleDto> listAlertRules(String userId);
    WatchlistDtos.AlertRuleDto getAlertRuleDetail(String userId, UUID alertRuleId);
    WatchlistDtos.AlertRuleDto updateAlertRule(WatchlistDtos.UpdateAlertRuleRequestDto request);
    void deleteAlertRule(UUID alertRuleId, String userId);
    void updateAlertRuleStatus(UUID alertRuleId, String userId, String status);
    List<WatchlistDtos.WatchlistGenerationRuleDto> listRules(String userId);
    WatchlistDtos.WatchlistGenerationRuleDto saveRule(WatchlistDtos.SaveWatchlistGenerationRuleRequestDto request);
    WatchlistDtos.WatchlistGenerationRuleDto updateRule(WatchlistDtos.UpdateWatchlistGenerationRuleRequestDto request);
    void deleteRule(UUID ruleId, String userId);
    WatchlistDtos.GenerateWatchlistFromRuleResponseDto generateRule(UUID ruleId, String userId);
}
