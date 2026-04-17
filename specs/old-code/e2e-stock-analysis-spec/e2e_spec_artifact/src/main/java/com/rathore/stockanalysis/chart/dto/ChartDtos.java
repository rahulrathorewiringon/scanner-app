package com.rathore.stockanalysis.chart.dto;

import java.util.List;

public final class ChartDtos {
    private ChartDtos() {}

    public record ChartRequest(
        String exchangeCode,
        long instrumentId,
        List<String> timeframes,
        String from,
        String to,
        boolean includeSma,
        boolean includePivots,
        boolean includePivotCandles
    ) {}

    public record MultiTimeframeChartsDto(
        long instrumentId,
        String exchangeCode,
        String symbol,
        SeriesBundle series,
        OverlayBundle overlays
    ) {}

    public record SeriesBundle(ChartSeriesDto week, ChartSeriesDto day, ChartSeriesDto hour) {}
    public record OverlayBundle(ChartOverlayDto week, ChartOverlayDto day, ChartOverlayDto hour) {}

    public record ChartSeriesDto(String timeframe, List<ChartCandleDto> candles) {}

    public record ChartCandleDto(
        String barStartTs,
        String barEndTs,
        String tradeDate,
        long tfId,
        double open,
        double high,
        double low,
        double close,
        Double volume
    ) {}

    public record ChartOverlayDto(SmaLines sma, List<PivotMarkerDto> pivots) {}

    public record SmaLines(
        List<LinePointDto> sma5,
        List<LinePointDto> sma10,
        List<LinePointDto> sma20,
        List<LinePointDto> sma50,
        List<LinePointDto> sma100,
        List<LinePointDto> sma200
    ) {}

    public record LinePointDto(String time, double value) {}

    public record PivotMarkerDto(
        String barStartTs,
        String pivotType,
        boolean pivotConfirmed,
        Double pivotPrice,
        String trendPivotType
    ) {}
}
