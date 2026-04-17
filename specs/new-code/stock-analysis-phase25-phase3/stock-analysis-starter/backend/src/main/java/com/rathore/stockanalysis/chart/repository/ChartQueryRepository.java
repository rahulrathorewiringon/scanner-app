package com.rathore.stockanalysis.chart.repository;

import com.rathore.stockanalysis.chart.dto.ChartOverlayDto;
import com.rathore.stockanalysis.chart.dto.ChartSeriesDto;

public interface ChartQueryRepository {
    String fetchSymbol(String exchangeCode, long instrumentId);
    ChartSeriesDto fetchSeries(String exchangeCode, long instrumentId, String timeframe);
    ChartOverlayDto fetchOverlay(String exchangeCode, long instrumentId, String timeframe, boolean includeSma, boolean includePivots);
}
