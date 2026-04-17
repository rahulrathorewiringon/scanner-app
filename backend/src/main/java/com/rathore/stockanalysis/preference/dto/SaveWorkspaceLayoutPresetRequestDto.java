package com.rathore.stockanalysis.preference.dto;

import java.util.Map;

public record SaveWorkspaceLayoutPresetRequestDto(
        String userId,
        String name,
        String exchangeCode,
        Map<String, Object> layoutJson,
        Boolean isDefault,
        Boolean isFavorite
) {}
