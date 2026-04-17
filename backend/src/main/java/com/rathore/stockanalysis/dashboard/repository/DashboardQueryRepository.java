package com.rathore.stockanalysis.dashboard.repository;

import com.rathore.stockanalysis.dashboard.dto.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardOverviewDto;

public interface DashboardQueryRepository {
    DashboardOverviewDto fetchOverview(String exchangeCode, String tradeDate, String timeframe);
    DataCoverageDto fetchDataCoverage(String exchangeCode);
}
