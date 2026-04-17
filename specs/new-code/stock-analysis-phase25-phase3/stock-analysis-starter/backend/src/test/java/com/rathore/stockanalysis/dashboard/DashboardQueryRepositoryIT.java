package com.rathore.stockanalysis.dashboard;

import com.rathore.stockanalysis.dashboard.dto.DashboardOverviewDto;
import com.rathore.stockanalysis.dashboard.dto.DataCoverageDto;
import com.rathore.stockanalysis.dashboard.repository.DashboardQueryRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.jupiter.api.Assertions.*;

class DashboardQueryRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired DashboardQueryRepository repository;

    @Test
    void shouldReturnOverviewCounts() {
        DashboardOverviewDto dto = repository.fetchOverview("NSE", "2026-04-17", "day");
        assertEquals(3, dto.totalActiveInstruments());
        assertEquals(2, dto.instrumentsWithData());
        assertEquals(1, dto.uptrendCount());
        assertEquals(1, dto.downtrendCount());
    }

    @Test
    void shouldReturnCoverageFromBootstrap() {
        DataCoverageDto dto = repository.fetchDataCoverage("NSE");
        assertEquals(3, dto.totalActiveInstruments());
        assertEquals(2, dto.chartDataExistsCount());
        assertTrue(dto.byTimeframeAvailability().day() >= 2);
    }
}
