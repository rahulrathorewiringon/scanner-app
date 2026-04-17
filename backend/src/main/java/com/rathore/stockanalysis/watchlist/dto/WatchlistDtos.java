package com.rathore.stockanalysis.watchlist.dto;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public class WatchlistDtos {
    public record WatchlistDefinitionDto(UUID watchlistId, String userId, String name, String exchangeCode,
                                         String watchlistType, String ruleEngineType, String createdAt, String updatedAt) {}
    public record CreateWatchlistRequestDto(String userId, String name, String exchangeCode, String watchlistType, String ruleEngineType) {}
    public record UpdateWatchlistRequestDto(UUID watchlistId, String userId, String name, String exchangeCode, String watchlistType, String ruleEngineType) {}

    public record WatchlistItemDto(UUID watchlistItemId, UUID watchlistId, long instrumentId, String symbol,
                                   String note, String sourceRuleId, String createdAt) {}
    public record CreateWatchlistItemRequestDto(String userId, long instrumentId, String note) {}
    public record UpdateWatchlistItemRequestDto(UUID watchlistItemId, String userId, String note) {}

    public record WatchlistDetailDto(WatchlistDefinitionDto watchlist, List<WatchlistItemDto> items, List<WatchlistGenerationRuleDto> rules) {}

    public record AlertRuleDto(UUID alertRuleId, String userId, String exchangeCode, long instrumentId, String symbol,
                               String ruleName, String ruleType, String status, UUID sourceWatchlistId,
                               String configJson, String createdAt, String updatedAt) {}
    public record UpdateAlertRuleRequestDto(UUID alertRuleId, String userId, String ruleName, String ruleType, String status, String configJson) {}

    public record WatchlistGenerationRuleDto(UUID ruleId, UUID watchlistId, String userId, String name,
                                             String exchangeCode, String ruleType, Map<String, Object> ruleDefinition,
                                             boolean isEnabled, String lastGeneratedAt, String createdAt, String updatedAt) {}

    public record SaveWatchlistGenerationRuleRequestDto(String userId, UUID watchlistId, String name,
                                                        String exchangeCode, String ruleType,
                                                        Map<String, Object> ruleDefinition, Boolean isEnabled) {}

    public record UpdateWatchlistGenerationRuleRequestDto(UUID ruleId, String userId, UUID watchlistId, String name,
                                                          String exchangeCode, String ruleType,
                                                          Map<String, Object> ruleDefinition, Boolean isEnabled) {}

    public record GenerateWatchlistFromRuleResponseDto(UUID ruleId, UUID watchlistId, int insertedCount,
                                                       List<Long> instrumentIds, String generatedAt) {}
}
