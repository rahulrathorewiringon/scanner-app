package com.rathore.stockanalysis.dashboard.dto;

import java.util.List;

public record DashboardOverviewDto(
        String exchangeCode,
        String tradeDate,
        String timeframe,
        long totalActiveInstruments,
        long instrumentsWithData,
        long uptrendCount,
        long downtrendCount,
        long sidewaysCount,
        String latestChartToDate,
        String latestBootstrapCompletedAt,
        TimeframeCoverage timeframeCoverage,
        List<SectorBucket> sectorBuckets
) {
    public record TimeframeCoverage(long hourCount, long dayCount, long weekCount) {}
    public record SectorBucket(String sector, long total, long uptrend, long downtrend, long sideways) {}
}
