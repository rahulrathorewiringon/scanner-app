package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record ScreenerBulkActionResponseDto(
        UUID actionId,
        String actionType,
        int acceptedCount,
        String message,
        String domainEntityType,
        String domainEntityId
) {}
