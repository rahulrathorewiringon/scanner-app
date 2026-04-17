package com.rathore.stockanalysis.instrument.service.impl;

import com.rathore.stockanalysis.instrument.dto.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSearchResponseDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.repository.InstrumentQueryRepository;
import com.rathore.stockanalysis.instrument.service.InstrumentService;
import org.springframework.stereotype.Service;

@Service
public class InstrumentServiceImpl implements InstrumentService {

    private final InstrumentQueryRepository instrumentQueryRepository;

    public InstrumentServiceImpl(InstrumentQueryRepository instrumentQueryRepository) {
        this.instrumentQueryRepository = instrumentQueryRepository;
    }

    @Override
    public InstrumentSearchResponseDto search(InstrumentSearchRequestDto request) {
        return instrumentQueryRepository.search(request);
    }

    @Override
    public InstrumentSummaryDto getSummary(String exchangeCode, long instrumentId) {
        return instrumentQueryRepository.fetchSummary(exchangeCode, instrumentId);
    }
}
