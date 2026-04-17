package com.rathore.stockanalysis.instrument.dto;

public record PivotEventDto(
        String timeframe,
        String barStartTs,
        long tfId,
        String pivotType,
        boolean pivotConfirmed,
        Double pivotPrice,
        String trendPivotType
) {}
