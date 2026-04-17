package com.rathore.stockanalysis.preference.dto;

import java.util.Map;
import java.util.UUID;

public record UpdateWorkspaceLayoutPresetRequestDto(
        UUID presetId,
        String userId,
        String name,
        String exchangeCode,
        Map<String, Object> layoutJson,
        Boolean isDefault,
        Boolean isFavorite
) {}
