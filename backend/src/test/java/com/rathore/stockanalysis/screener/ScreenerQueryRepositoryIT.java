package com.rathore.stockanalysis.screener;

import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import com.rathore.stockanalysis.screener.repository.ScreenerQueryRepository;
import com.rathore.stockanalysis.screener.service.ScreenerService;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class ScreenerQueryRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired ScreenerQueryRepository repository;
    @Autowired ScreenerService screenerService;

    @Test
    void metadataShouldExposeConfiguredFields() {
        ScreenerDtos.ScreenerFilterMetadataDto metadata = screenerService.getFilterMetadata("NSE");
        assertFalse(metadata.fields().isEmpty());
        assertTrue(metadata.fields().stream().anyMatch(f -> "symbol".equals(f.key())));
        assertTrue(metadata.fields().stream().anyMatch(f -> "latestClose".equals(f.key())));
    }

    @Test
    void countShouldRespectSimpleCondition() {
        ScreenerDtos.ScreenerRunRequestDto request = requestFor(singleCondition("signal", "trendState", "day", "eq", Map.of("kind", "single", "value", "UPTREND")));
        long count = repository.count("NSE", request);
        assertEquals(1L, count);
    }

    @Test
    void runShouldSupportNestedAndOrGroupsAndPagination() {
        var root = new ScreenerDtos.ScreenerFilterGroupDto(
                "group", "root", "AND", true, List.of(
                new ScreenerDtos.ScreenerFilterGroupDto(
                        "group", "g1", "OR", true, List.of(
                        singleCondition("pivot", "latestPivotType", "day", "eq", Map.of("kind", "single", "value", "PH")),
                        singleCondition("instrument", "sector", "day", "contains", Map.of("kind", "single", "value", "IT"))
                )),
                singleCondition("instrument", "latestClose", "day", "gte", Map.of("kind", "single", "value", 2000))
        ));
        ScreenerDtos.ScreenerRunRequestDto request = new ScreenerDtos.ScreenerRunRequestDto(
                "NSE", "2026-04-17", "day", root,
                new ScreenerDtos.ScreenerRunRequestDto.Pagination(0, 10),
                List.of(new ScreenerDtos.ScreenerRunRequestDto.SortDef("latestClose", "desc"))
        );
        ScreenerDtos.ScreenerRunResponseDto response = repository.run("NSE", request);
        assertEquals(2, response.totalRows());
        assertEquals("TCS", response.rows().get(0).symbol());
    }

    private ScreenerDtos.ScreenerRunRequestDto requestFor(Object conditionOrGroup) {
        ScreenerDtos.ScreenerFilterGroupDto root = new ScreenerDtos.ScreenerFilterGroupDto(
                "group", "root", "AND", true, List.of(conditionOrGroup)
        );
        return new ScreenerDtos.ScreenerRunRequestDto(
                "NSE", "2026-04-17", "day", root,
                new ScreenerDtos.ScreenerRunRequestDto.Pagination(0, 25),
                List.of(new ScreenerDtos.ScreenerRunRequestDto.SortDef("symbol", "asc"))
        );
    }

    private ScreenerDtos.ScreenerConditionNodeDto singleCondition(
            String group, String field, String timeframe, String operator, Map<String, Object> value
    ) {
        return new ScreenerDtos.ScreenerConditionNodeDto(
                "condition", "c1", true, group, field, timeframe, operator, value
        );
    }
}
