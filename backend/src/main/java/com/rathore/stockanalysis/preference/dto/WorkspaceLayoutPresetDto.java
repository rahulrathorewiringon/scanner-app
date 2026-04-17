package com.rathore.stockanalysis.preference.dto;

import java.util.Map;
import java.util.UUID;

public record WorkspaceLayoutPresetDto(
        UUID presetId,
        String userId,
        String name,
        String exchangeCode,
        Map<String, Object> layoutJson,
        boolean isDefault,
        boolean isFavorite,
        String createdAt,
        String updatedAt
) {}
