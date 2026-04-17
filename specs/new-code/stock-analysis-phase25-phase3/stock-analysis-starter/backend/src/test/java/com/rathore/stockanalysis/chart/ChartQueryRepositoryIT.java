package com.rathore.stockanalysis.chart;

import com.rathore.stockanalysis.chart.dto.ChartOverlayDto;
import com.rathore.stockanalysis.chart.dto.ChartSeriesDto;
import com.rathore.stockanalysis.chart.repository.ChartQueryRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.jupiter.api.Assertions.*;

class ChartQueryRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired ChartQueryRepository repository;

    @Test
    void shouldReturnWeekDayHourSeries() {
        ChartSeriesDto day = repository.fetchSeries("NSE", 1L, "day");
        assertEquals("day", day.timeframe());
        assertFalse(day.candles().isEmpty());
    }

    @Test
    void shouldReturnOverlayWithSmaAndPivots() {
        ChartOverlayDto overlay = repository.fetchOverlay("NSE", 1L, "day", true, true);
        assertNotNull(overlay.sma());
        assertNotNull(overlay.pivots());
        assertFalse(overlay.pivots().isEmpty());
    }
}
