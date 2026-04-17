package com.rathore.stockanalysis.preference.dto;

import java.util.List;
import java.util.Map;

public record ScreenerBulkActionRequestDto(
        String userId,
        String actionType,
        List<Long> instrumentIds,
        Map<String, Object> payload
) {}
