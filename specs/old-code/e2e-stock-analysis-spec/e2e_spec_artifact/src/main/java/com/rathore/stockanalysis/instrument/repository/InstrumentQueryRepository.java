package com.rathore.stockanalysis.instrument.repository;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentRowDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;

public interface InstrumentQueryRepository {
    PagedResponse<InstrumentRowDto> search(String exchangeCode, String masterSchema, InstrumentSearchRequestDto request);
    InstrumentSummaryDto fetchSummary(String exchangeCode, String masterSchema, String marketSchema, long instrumentId, String tradeDate);
}
