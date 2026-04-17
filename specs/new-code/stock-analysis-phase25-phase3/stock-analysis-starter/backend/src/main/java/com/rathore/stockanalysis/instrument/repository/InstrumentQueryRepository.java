package com.rathore.stockanalysis.instrument.repository;

import com.rathore.stockanalysis.instrument.dto.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSearchResponseDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSummaryDto;

public interface InstrumentQueryRepository {
    InstrumentSearchResponseDto search(InstrumentSearchRequestDto request);
    InstrumentSummaryDto fetchSummary(String exchangeCode, long instrumentId);
}
