package com.rathore.stockanalysis.instrument.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import java.util.List;

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
        @Min(0) int pageIndex,
        @Min(1) @Max(500) int pageSize,
        List<SortSpecDto> sort
) {}
