package com.rathore.stockanalysis.chart.dto;

public record MultiTimeframeChartsDto(long instrumentId, String exchangeCode, String symbol,
                                      SeriesSet series, OverlaySet overlays) {
    public record SeriesSet(ChartSeriesDto week, ChartSeriesDto day, ChartSeriesDto hour) {}
    public record OverlaySet(ChartOverlayDto week, ChartOverlayDto day, ChartOverlayDto hour) {}
}
