package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record WorkspaceLayoutPresetShareDto(
        UUID shareId,
        UUID presetId,
        String ownerUserId,
        String sharedWithUserId,
        String permission,
        String createdAt
) {}
