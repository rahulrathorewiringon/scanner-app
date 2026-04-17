package com.rathore.stockanalysis.screener.repository;

import com.rathore.stockanalysis.screener.dto.ScreenerDtos;

public interface ScreenerQueryRepository {
    long count(String exchangeCode, ScreenerDtos.ScreenerRunRequestDto request);
    ScreenerDtos.ScreenerRunResponseDto run(String exchangeCode, ScreenerDtos.ScreenerRunRequestDto request);
}
