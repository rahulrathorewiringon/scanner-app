package com.rathore.stockanalysis.dashboard.dto;

import java.util.List;

public record DataCoverageDto(
        String exchangeCode,
        long totalActiveInstruments,
        long chartDataExistsCount,
        long staleCount,
        long rebuildRequiredCount,
        List<StatusCount> byBootstrapStatus,
        List<StatusCount> byChartDataStatus,
        TimeframeAvailability byTimeframeAvailability
) {
    public record StatusCount(String status, long count) {}
    public record TimeframeAvailability(long hour, long day, long week) {}
}
