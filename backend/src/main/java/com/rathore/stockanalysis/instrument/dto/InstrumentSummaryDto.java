package com.rathore.stockanalysis.instrument.dto;

import java.util.List;

public record InstrumentSummaryDto(
        Identity identity,
        DataAvailability dataAvailability,
        LatestPrices latestPrices,
        Trend trend,
        Pivots pivots,
        SmaStructure smaStructure,
        CandleAnalysis candleAnalysis
) {
    public record Identity(long instrumentId, String symbol, String tradingSymbol, String instrumentType,
                           String assetClass, String sector, String industry, String exchangeCode) {}
    public record DataAvailability(boolean chartDataExists, String bootstrapStatus, String chartDataStatus,
                                   String chartFromDate, String chartToDate, List<String> chartTimeframesAvailable,
                                   String reconcileWatermarkDate, String bootstrapCompletedThroughDate,
                                   String lastBootstrapCompletedAt, String lastReconcileCompletedAt) {}
    public record LatestPrices(LatestPriceSnapshotDto week, LatestPriceSnapshotDto day, LatestPriceSnapshotDto hour) {}
    public record Trend(String state, String source, String strength, String timeframe) {}
    public record Pivots(String latestPivotType, String previousPivotType, String latestTrendPivotType,
                         List<PivotEventDto> recentSequence) {}
    public record SmaStructure(String week, String day, String hour, String crossoverState, String slopeState) {}
    public record CandleAnalysis(String currentPattern, String previousPattern, Double bodyPct,
                                 Double upperWickPct, Double lowerWickPct, Double rangeToAtr) {}
}
