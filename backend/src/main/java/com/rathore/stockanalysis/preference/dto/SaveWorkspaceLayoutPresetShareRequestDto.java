package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record SaveWorkspaceLayoutPresetShareRequestDto(
        UUID presetId,
        String ownerUserId,
        String sharedWithUserId,
        String permission
) {}
