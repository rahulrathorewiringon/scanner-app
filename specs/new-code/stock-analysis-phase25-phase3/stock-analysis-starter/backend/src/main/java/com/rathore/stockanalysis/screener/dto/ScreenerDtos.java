package com.rathore.stockanalysis.screener.dto;

import java.util.List;
import java.util.Map;

public class ScreenerDtos {
    public record ScreenerFilterMetadataDto(String exchangeCode, List<String> timeframes, List<FieldDef> fields) {
        public record FieldDef(String group, String key, String label, List<String> operators, String valueType,
                               List<Map<String, String>> options) {}
    }

    public record ScreenerConditionNodeDto(String type, String id, boolean enabled, String fieldGroup,
                                           String field, String timeframe, String operator, Map<String, Object> value) {}

    public record ScreenerFilterGroupDto(String type, String id, String operator, boolean enabled,
                                         List<Object> children) {}

    public record ScreenerRunRequestDto(String exchangeCode, String tradeDate, String defaultTimeframe,
                                        ScreenerFilterGroupDto filterTree, Pagination pagination, List<SortDef> sort) {
        public record Pagination(int pageIndex, int pageSize) {}
        public record SortDef(String field, String direction) {}
    }

    public record ScreenerResultRowDto(long instrumentId, String symbol, String sector, String timeframe,
                                       Double latestClose, String currentCandleType, String latestPivotType,
                                       String previousPivotType, String smaAlignmentSummary,
                                       String signalSummary, String updatedAt) {}

    public record ScreenerRunResponseDto(List<ScreenerResultRowDto> rows, long totalRows, int pageIndex, int pageSize) {}
    public record ScreenerCountResponseDto(long count) {}
}
