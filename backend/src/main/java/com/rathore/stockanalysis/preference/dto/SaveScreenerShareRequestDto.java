package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record SaveScreenerShareRequestDto(UUID screenerId, String ownerUserId, String sharedWithUserId, String permission) {}
