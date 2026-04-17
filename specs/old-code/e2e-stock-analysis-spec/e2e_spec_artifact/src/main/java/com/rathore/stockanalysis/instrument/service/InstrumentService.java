package com.rathore.stockanalysis.instrument.service;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentRowDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;

public interface InstrumentService {
    PagedResponse<InstrumentRowDto> search(InstrumentSearchRequestDto request);
    InstrumentSummaryDto getSummary(String exchangeCode, long instrumentId, String tradeDate);
}
