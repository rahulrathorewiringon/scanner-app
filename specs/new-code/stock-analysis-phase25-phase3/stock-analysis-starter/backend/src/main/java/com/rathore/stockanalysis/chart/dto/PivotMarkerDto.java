package com.rathore.stockanalysis.chart.dto;

public record PivotMarkerDto(String barStartTs, String pivotType, boolean pivotConfirmed,
                             Double pivotPrice, String trendPivotType) {}
