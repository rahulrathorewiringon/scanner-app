package com.rathore.stockanalysis.chart.service;

import com.rathore.stockanalysis.chart.dto.ChartDtos.ChartRequest;
import com.rathore.stockanalysis.chart.dto.ChartDtos.MultiTimeframeChartsDto;

public interface ChartService {
    MultiTimeframeChartsDto getCharts(ChartRequest request);
}
