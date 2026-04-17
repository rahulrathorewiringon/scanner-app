package com.rathore.stockanalysis.chart.dto;

public record ChartCandleDto(String barStartTs, String barEndTs, String tradeDate, long tfId,
                             double open, double high, double low, double close, Double volume) {}
