package com.rathore.stockanalysis.chart.controller;

import com.rathore.stockanalysis.chart.dto.ChartDtos.ChartRequest;
import com.rathore.stockanalysis.chart.dto.ChartDtos.MultiTimeframeChartsDto;
import com.rathore.stockanalysis.chart.service.ChartService;
import java.util.Arrays;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/instruments")
public class ChartController {
    private final ChartService chartService;

    public ChartController(ChartService chartService) {
        this.chartService = chartService;
    }

    @GetMapping("/{instrumentId}/charts")
    public MultiTimeframeChartsDto getCharts(
        @PathVariable long instrumentId,
        @RequestParam String exchangeCode,
        @RequestParam(defaultValue = "week,day,hour") String timeframes,
        @RequestParam(required = false) String from,
        @RequestParam(required = false) String to,
        @RequestParam(defaultValue = "true") boolean includeSma,
        @RequestParam(defaultValue = "true") boolean includePivots,
        @RequestParam(defaultValue = "false") boolean includePivotCandles
    ) {
        return chartService.getCharts(new ChartRequest(
            exchangeCode,
            instrumentId,
            Arrays.stream(timeframes.split(",")).map(String::trim).toList(),
            from,
            to,
            includeSma,
            includePivots,
            includePivotCandles
        ));
    }
}
