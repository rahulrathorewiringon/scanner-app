package com.rathore.stockanalysis.instrument.dto;

import java.util.List;

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
