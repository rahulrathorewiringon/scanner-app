package com.rathore.stockanalysis.screener.repository;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerFilterMetadataDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerResultRowDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerRunRequestDto;

public interface ScreenerQueryRepository {
    ScreenerFilterMetadataDto fetchMetadata(String exchangeCode);
    long count(String exchangeCode, String masterSchema, String marketSchema, ScreenerRunRequestDto request);
    PagedResponse<ScreenerResultRowDto> run(String exchangeCode, String masterSchema, String marketSchema, ScreenerRunRequestDto request);
}
