package com.rathore.stockanalysis.dashboard.service;

import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DashboardOverviewDto;
import java.time.LocalDate;

public interface DashboardService {
    DashboardOverviewDto getOverview(String exchangeCode, LocalDate tradeDate, String timeframe);
    DataCoverageDto getDataCoverage(String exchangeCode);
}
