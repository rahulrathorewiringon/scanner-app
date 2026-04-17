package com.rathore.stockanalysis.preference.dto;

import java.util.Map;
import java.util.UUID;

public record SavedScreenerDefinitionDto(
        UUID screenerId,
        String userId,
        String name,
        String exchangeCode,
        String tradeDate,
        String defaultTimeframe,
        Map<String, Object> filterTree,
        Object sortSpec,
        int pageSize,
        String createdAt,
        String updatedAt
) {}
