package com.rathore.stockanalysis.dashboard.service.impl;

import com.rathore.stockanalysis.dashboard.dto.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardOverviewDto;
import com.rathore.stockanalysis.dashboard.repository.DashboardQueryRepository;
import com.rathore.stockanalysis.dashboard.service.DashboardService;
import org.springframework.stereotype.Service;

@Service
public class DashboardServiceImpl implements DashboardService {

    private final DashboardQueryRepository dashboardQueryRepository;

    public DashboardServiceImpl(DashboardQueryRepository dashboardQueryRepository) {
        this.dashboardQueryRepository = dashboardQueryRepository;
    }

    @Override
    public DashboardOverviewDto getOverview(String exchangeCode, String tradeDate, String timeframe) {
        return dashboardQueryRepository.fetchOverview(exchangeCode, tradeDate, timeframe);
    }

    @Override
    public DataCoverageDto getDataCoverage(String exchangeCode) {
        return dashboardQueryRepository.fetchDataCoverage(exchangeCode);
    }
}
