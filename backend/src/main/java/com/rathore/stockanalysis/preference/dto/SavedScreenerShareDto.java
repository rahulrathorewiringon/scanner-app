package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record SavedScreenerShareDto(UUID shareId, UUID screenerId, String ownerUserId, String sharedWithUserId, String permission, String createdAt) {}
