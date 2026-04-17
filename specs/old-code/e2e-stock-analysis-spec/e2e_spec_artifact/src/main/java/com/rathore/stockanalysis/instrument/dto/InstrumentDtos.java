package com.rathore.stockanalysis.instrument.dto;

import java.util.List;

public final class InstrumentDtos {
    private InstrumentDtos() {}

    public record PagedResponse<T>(List<T> rows, long totalRows, int pageIndex, int pageSize) {}

    public record InstrumentSearchRequestDto(
        String exchangeCode,
        String tradeDate,
        String trendFilter,
        List<String> timeframeFilter,
        String sector,
        String symbolQuery,
        String candleType,
        String pivotType,
        String smaStructure,
        Pagination pagination,
        List<SortDto> sort
    ) {}

    public record Pagination(int pageIndex, int pageSize) {}
    public record SortDto(String field, String direction) {}

    public record InstrumentRowDto(
        long instrumentId,
        String symbol,
        String tradingSymbol,
        String instrumentType,
        String sector,
        String exchangeCode,
        String latestTradeDate,
        boolean chartDataExists,
        List<String> chartTimeframesAvailable,
        String bootstrapStatus,
        String chartDataStatus,
        String trendState,
        String currentCandlePattern,
        String latestPivotType,
        String latestTrendPivotType,
        String smaStructure,
        String updatedAt
    ) {}

    public record LatestPriceSnapshotDto(
        String timeframe,
        String tradeDate,
        long tfId,
        String barStartTs,
        double open,
        double high,
        double low,
        double close,
        Double volume
    ) {}

    public record PivotEventDto(
        String timeframe,
        String barStartTs,
        long tfId,
        String pivotType,
        boolean pivotConfirmed,
        Double pivotPrice,
        String trendPivotType
    ) {}

    public record InstrumentSummaryDto(
        Identity identity,
        DataAvailability dataAvailability,
        LatestPrices latestPrices,
        Trend trend,
        Pivots pivots,
        SmaStructure smaStructure,
        CandleAnalysis candleAnalysis
    ) {}

    public record Identity(
        long instrumentId,
        String symbol,
        String tradingSymbol,
        String instrumentType,
        String assetClass,
        String sector,
        String industry,
        String exchangeCode
    ) {}

    public record DataAvailability(
        boolean chartDataExists,
        String bootstrapStatus,
        String chartDataStatus,
        String chartFromDate,
        String chartToDate,
        List<String> chartTimeframesAvailable,
        String reconcileWatermarkDate,
        String bootstrapCompletedThroughDate,
        String lastBootstrapCompletedAt,
        String lastReconcileCompletedAt
    ) {}

    public record LatestPrices(
        LatestPriceSnapshotDto week,
        LatestPriceSnapshotDto day,
        LatestPriceSnapshotDto hour
    ) {}

    public record Trend(String state, String source, String strength, String timeframe) {}

    public record Pivots(
        String latestPivotType,
        String previousPivotType,
        String latestTrendPivotType,
        List<PivotEventDto> recentSequence
    ) {}

    public record SmaStructure(
        String week,
        String day,
        String hour,
        String crossoverState,
        String slopeState
    ) {}

    public record CandleAnalysis(
        String currentPattern,
        String previousPattern,
        Double bodyPct,
        Double upperWickPct,
        Double lowerWickPct,
        Double rangeToAtr
    ) {}
}
