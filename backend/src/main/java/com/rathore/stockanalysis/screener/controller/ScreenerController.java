package com.rathore.stockanalysis.screener.controller;

import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import com.rathore.stockanalysis.screener.service.ScreenerService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/screener")
@Validated
public class ScreenerController {
    private final ScreenerService screenerService;

    public ScreenerController(ScreenerService screenerService) {
        this.screenerService = screenerService;
    }

    @GetMapping("/filter-metadata")
    public ScreenerDtos.ScreenerFilterMetadataDto getFilterMetadata(@RequestParam @NotBlank String exchangeCode) {
        return screenerService.getFilterMetadata(exchangeCode);
    }

    @PostMapping("/count")
    public ScreenerDtos.ScreenerCountResponseDto count(@RequestBody @Valid ScreenerDtos.ScreenerRunRequestDto request) {
        return screenerService.count(request);
    }

    @PostMapping("/run")
    public ScreenerDtos.ScreenerRunResponseDto run(@RequestBody @Valid ScreenerDtos.ScreenerRunRequestDto request) {
        return screenerService.run(request);
    }
}
