package com.rathore.stockanalysis.preference.dto;

import java.util.UUID;

public record SavedScreenerTagDto(UUID screenerId, String tag, String createdAt) {}
