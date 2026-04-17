package com.rathore.stockanalysis.chart.service.impl;

import com.rathore.stockanalysis.chart.dto.ChartOverlayDto;
import com.rathore.stockanalysis.chart.dto.ChartSeriesDto;
import com.rathore.stockanalysis.chart.dto.MultiTimeframeChartsDto;
import com.rathore.stockanalysis.chart.repository.ChartQueryRepository;
import com.rathore.stockanalysis.chart.service.ChartService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChartServiceImpl implements ChartService {

    private final ChartQueryRepository chartQueryRepository;

    public ChartServiceImpl(ChartQueryRepository chartQueryRepository) {
        this.chartQueryRepository = chartQueryRepository;
    }

    @Override
    public MultiTimeframeChartsDto getCharts(String exchangeCode, long instrumentId, List<String> timeframes,
                                             boolean includeSma, boolean includePivots, boolean includePivotCandles) {
        List<String> effective = (timeframes == null || timeframes.isEmpty()) ? List.of("week", "day", "hour") : timeframes;
        ChartSeriesDto week = effective.contains("week") ? chartQueryRepository.fetchSeries(exchangeCode, instrumentId, "week") : null;
        ChartSeriesDto day = effective.contains("day") ? chartQueryRepository.fetchSeries(exchangeCode, instrumentId, "day") : null;
        ChartSeriesDto hour = effective.contains("hour") ? chartQueryRepository.fetchSeries(exchangeCode, instrumentId, "hour") : null;
        ChartOverlayDto weekOverlay = effective.contains("week") ? chartQueryRepository.fetchOverlay(exchangeCode, instrumentId, "week", includeSma, includePivots) : null;
        ChartOverlayDto dayOverlay = effective.contains("day") ? chartQueryRepository.fetchOverlay(exchangeCode, instrumentId, "day", includeSma, includePivots) : null;
        ChartOverlayDto hourOverlay = effective.contains("hour") ? chartQueryRepository.fetchOverlay(exchangeCode, instrumentId, "hour", includeSma, includePivots) : null;
        String symbol = chartQueryRepository.fetchSymbol(exchangeCode, instrumentId);
        return new MultiTimeframeChartsDto(
                instrumentId,
                exchangeCode,
                symbol,
                new MultiTimeframeChartsDto.SeriesSet(week, day, hour),
                new MultiTimeframeChartsDto.OverlaySet(weekOverlay, dayOverlay, hourOverlay)
        );
    }
}
