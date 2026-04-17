package com.rathore.stockanalysis.instrument.service;

import com.rathore.stockanalysis.instrument.dto.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSearchResponseDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSummaryDto;

public interface InstrumentService {
    InstrumentSearchResponseDto search(InstrumentSearchRequestDto request);
    InstrumentSummaryDto getSummary(String exchangeCode, long instrumentId);
}
