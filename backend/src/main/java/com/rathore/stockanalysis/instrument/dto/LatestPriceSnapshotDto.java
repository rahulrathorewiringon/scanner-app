package com.rathore.stockanalysis.instrument.dto;

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
