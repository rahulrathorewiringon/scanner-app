package com.rathore.stockanalysis.instrument.controller;

import com.rathore.stockanalysis.instrument.dto.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSearchResponseDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.service.InstrumentService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class InstrumentController {

    private final InstrumentService instrumentService;

    public InstrumentController(InstrumentService instrumentService) {
        this.instrumentService = instrumentService;
    }

    @PostMapping("/analytics/instruments/search")
    public InstrumentSearchResponseDto search(@Valid @RequestBody InstrumentSearchRequestDto request) {
        return instrumentService.search(request);
    }

    @GetMapping("/instruments/{instrumentId}/summary")
    public InstrumentSummaryDto getSummary(
            @PathVariable long instrumentId,
            @RequestParam(defaultValue = "NSE") String exchangeCode
    ) {
        return instrumentService.getSummary(exchangeCode, instrumentId);
    }
}
