package com.rathore.stockanalysis.dashboard.controller;

import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.dto.DashboardDtos.DashboardOverviewDto;
import com.rathore.stockanalysis.dashboard.service.DashboardService;
import java.time.LocalDate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/analytics")
public class DashboardController {
    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/dashboard-overview")
    public DashboardOverviewDto getOverview(
        @RequestParam String exchangeCode,
        @RequestParam LocalDate tradeDate,
        @RequestParam(defaultValue = "day") String timeframe
    ) {
        return dashboardService.getOverview(exchangeCode, tradeDate, timeframe);
    }

    @GetMapping("/data-coverage")
    public DataCoverageDto getDataCoverage(@RequestParam String exchangeCode) {
        return dashboardService.getDataCoverage(exchangeCode);
    }
}
