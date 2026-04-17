package com.rathore.stockanalysis.chart.repository;

import com.rathore.stockanalysis.chart.dto.ChartDtos.ChartRequest;
import com.rathore.stockanalysis.chart.dto.ChartDtos.MultiTimeframeChartsDto;

public interface ChartQueryRepository {
    MultiTimeframeChartsDto fetchCharts(String exchangeCode, String marketSchema, ChartRequest request);
}
