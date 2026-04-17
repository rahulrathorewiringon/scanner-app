package com.rathore.stockanalysis.screener.controller;

import com.rathore.stockanalysis.instrument.dto.InstrumentDtos.PagedResponse;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerFilterMetadataDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerResultRowDto;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos.ScreenerRunRequestDto;
import com.rathore.stockanalysis.screener.service.ScreenerService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/screener")
public class ScreenerController {
    private final ScreenerService screenerService;

    public ScreenerController(ScreenerService screenerService) {
        this.screenerService = screenerService;
    }

    @GetMapping("/filter-metadata")
    public ScreenerFilterMetadataDto getFilterMetadata(@RequestParam String exchangeCode) {
        return screenerService.getFilterMetadata(exchangeCode);
    }

    @PostMapping("/count")
    public long count(@RequestBody ScreenerRunRequestDto request) {
        return screenerService.count(request);
    }

    @PostMapping("/run")
    public PagedResponse<ScreenerResultRowDto> run(@RequestBody ScreenerRunRequestDto request) {
        return screenerService.run(request);
    }
}
