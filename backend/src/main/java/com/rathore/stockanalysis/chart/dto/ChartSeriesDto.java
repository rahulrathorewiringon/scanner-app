package com.rathore.stockanalysis.chart.dto;

import java.util.List;

public record ChartSeriesDto(String timeframe, List<ChartCandleDto> candles) {}
