package com.rathore.stockanalysis.screener.service;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerFilterMetadataDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerResultRowDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerRunRequestDto;

public interface ScreenerService {
    ScreenerFilterMetadataDto getFilterMetadata(String exchangeCode);
    long count(ScreenerRunRequestDto request);
    PagedResponse<ScreenerResultRowDto> run(ScreenerRunRequestDto request);
}
