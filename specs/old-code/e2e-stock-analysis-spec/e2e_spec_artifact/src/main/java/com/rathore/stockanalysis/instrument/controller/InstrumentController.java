package com.rathore.stockanalysis.instrument.controller;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.InstrumentRowDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;
import com.rathore.stockanalysis.instrument.service.InstrumentService;
import org.springframework.web.bind.annotation.*;

@RestController
public class InstrumentController {
    private final InstrumentService instrumentService;

    public InstrumentController(InstrumentService instrumentService) {
        this.instrumentService = instrumentService;
    }

    @PostMapping("/api/analytics/instruments/search")
    public PagedResponse<InstrumentRowDto> search(@RequestBody InstrumentSearchRequestDto request) {
        return instrumentService.search(request);
    }

    @GetMapping("/api/instruments/{instrumentId}/summary")
    public InstrumentSummaryDto getSummary(
        @PathVariable long instrumentId,
        @RequestParam String exchangeCode,
        @RequestParam String tradeDate
    ) {
        return instrumentService.getSummary(exchangeCode, instrumentId, tradeDate);
    }
}
