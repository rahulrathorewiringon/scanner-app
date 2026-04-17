package com.rathore.stockanalysis.screener.service;

import com.rathore.stockanalysis.screener.dto.ScreenerDtos;

public interface ScreenerService {
    ScreenerDtos.ScreenerFilterMetadataDto getFilterMetadata(String exchangeCode);
    ScreenerDtos.ScreenerCountResponseDto count(ScreenerDtos.ScreenerRunRequestDto request);
    ScreenerDtos.ScreenerRunResponseDto run(ScreenerDtos.ScreenerRunRequestDto request);
}
