package com.rathore.stockanalysis.chart.service;

import com.rathore.stockanalysis.chart.dto.MultiTimeframeChartsDto;

import java.util.List;

public interface ChartService {
    MultiTimeframeChartsDto getCharts(String exchangeCode, long instrumentId, List<String> timeframes,
                                      boolean includeSma, boolean includePivots, boolean includePivotCandles);
}
