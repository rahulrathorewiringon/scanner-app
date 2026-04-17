package com.rathore.stockanalysis.instrument;

import com.rathore.stockanalysis.instrument.dto.InstrumentSearchRequestDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSearchResponseDto;
import com.rathore.stockanalysis.instrument.dto.InstrumentSummaryDto;
import com.rathore.stockanalysis.instrument.dto.SortSpecDto;
import com.rathore.stockanalysis.instrument.repository.InstrumentQueryRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class InstrumentQueryRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired InstrumentQueryRepository repository;

    @Test
    void searchShouldSupportPaginationAndFilters() {
        InstrumentSearchRequestDto request = new InstrumentSearchRequestDto("NSE", "2026-04-17", "UPTREND", null, null, null, null, null, null, 0, 20, List.of(new SortSpecDto("symbol", "asc")));
        InstrumentSearchResponseDto response = repository.search(request);
        assertEquals(1, response.totalRows());
        assertEquals("RELIANCE", response.rows().getFirst().symbol());
    }

    @Test
    void shouldReturnNormalizedSummary() {
        InstrumentSummaryDto summary = repository.fetchSummary("NSE", 1L);
        assertEquals("RELIANCE", summary.identity().symbol());
        assertTrue(summary.dataAvailability().chartDataExists());
        assertEquals("UPTREND", summary.trend().state());
        assertNotNull(summary.latestPrices().day());
    }
}
