package com.rathore.stockanalysis.chart.controller;

import com.rathore.stockanalysis.chart.dto.MultiTimeframeChartsDto;
import com.rathore.stockanalysis.chart.service.ChartService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

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
            @RequestParam(defaultValue = "NSE") String exchangeCode,
            @RequestParam(defaultValue = "week,day,hour") String timeframes,
            @RequestParam(defaultValue = "true") boolean includeSma,
            @RequestParam(defaultValue = "true") boolean includePivots,
            @RequestParam(defaultValue = "false") boolean includePivotCandles
    ) {
        List<String> tfList = Arrays.stream(timeframes.split(","))
                .map(String::trim)
                .filter(s -> !s.isBlank())
                .toList();
        return chartService.getCharts(exchangeCode, instrumentId, tfList, includeSma, includePivots, includePivotCandles);
    }
}
