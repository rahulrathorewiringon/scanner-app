package com.rathore.stockanalysis.preference.dto;

import java.util.Map;

public record SaveScreenerRequestDto(
        String userId,
        String name,
        String exchangeCode,
        String tradeDate,
        String defaultTimeframe,
        Map<String, Object> filterTree,
        Object sortSpec,
        int pageSize
) {}
