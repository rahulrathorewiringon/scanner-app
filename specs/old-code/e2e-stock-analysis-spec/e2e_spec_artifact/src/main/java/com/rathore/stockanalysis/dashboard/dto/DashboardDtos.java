package com.rathore.stockanalysis.dashboard.dto;

import java.time.LocalDate;
import java.util.List;

public final class DashboardDtos {
    private DashboardDtos() {}

    public record DashboardOverviewDto(
        String exchangeCode,
        LocalDate tradeDate,
        String timeframe,
        long totalActiveInstruments,
        long instrumentsWithData,
        long uptrendCount,
        long downtrendCount,
        long sidewaysCount,
        LocalDate latestChartToDate,
        String latestBootstrapCompletedAt,
        TimeframeCoverage timeframeCoverage,
        List<SectorBucketDto> sectorBuckets
    ) {}

    public record TimeframeCoverage(long hourCount, long dayCount, long weekCount) {}

    public record SectorBucketDto(
        String sector,
        long total,
        long uptrend,
        long downtrend,
        long sideways
    ) {}

    public record DataCoverageDto(
        String exchangeCode,
        long totalActiveInstruments,
        long chartDataExistsCount,
        long staleCount,
        long rebuildRequiredCount,
        List<StatusCountDto> byBootstrapStatus,
        List<StatusCountDto> byChartDataStatus,
        TimeframeCoverage byTimeframeAvailability
    ) {}

    public record StatusCountDto(String status, long count) {}
}
