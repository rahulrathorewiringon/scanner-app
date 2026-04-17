package com.rathore.stockanalysis.dashboard.service;

import com.rathore.stockanalysis.dashboard.dto.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardOverviewDto;

public interface DashboardService {
    DashboardOverviewDto getOverview(String exchangeCode, String tradeDate, String timeframe);
    DataCoverageDto getDataCoverage(String exchangeCode);
}
