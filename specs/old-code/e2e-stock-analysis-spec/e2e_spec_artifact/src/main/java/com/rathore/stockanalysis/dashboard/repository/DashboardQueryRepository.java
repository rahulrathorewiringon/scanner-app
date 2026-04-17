package com.rathore.stockanalysis.dashboard.repository;

import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DashboardOverviewDto;
import java.time.LocalDate;

public interface DashboardQueryRepository {
    DashboardOverviewDto fetchOverview(String exchangeCode, String masterSchema, LocalDate tradeDate, String timeframe);
    DataCoverageDto fetchDataCoverage(String exchangeCode, String masterSchema);
}
