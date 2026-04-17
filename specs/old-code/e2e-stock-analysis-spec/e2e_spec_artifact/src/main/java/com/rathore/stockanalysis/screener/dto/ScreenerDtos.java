package com.rathore.stockanalysis.screener.dto;

import java.util.List;

public final class ScreenerDtos {
    private ScreenerDtos() {}

    public record ScreenerFilterMetadataDto(String exchangeCode, List<String> timeframes, List<FieldDto> fields) {}
    public record FieldDto(String group, String key, String label, List<String> operators, String valueType, List<OptionDto> options) {}
    public record OptionDto(String value, String label) {}

    public record ScreenerRunRequestDto(
        String exchangeCode,
        String tradeDate,
        String defaultTimeframe,
        ScreenerFilterGroupDto filterTree,
        Pagination pagination,
        List<SortDto> sort
    ) {}

    public record Pagination(int pageIndex, int pageSize) {}
    public record SortDto(String field, String direction) {}

    public sealed interface ScreenerFilterNodeDto permits ScreenerFilterGroupDto, ScreenerConditionDto {}

    public record ScreenerFilterGroupDto(
        String type,
        String id,
        String operator,
        boolean enabled,
        List<ScreenerFilterNodeDto> children
    ) implements ScreenerFilterNodeDto {}

    public record ScreenerConditionDto(
        String type,
        String id,
        boolean enabled,
        String fieldGroup,
        String field,
        String timeframe,
        String operator,
        FilterValueDto value
    ) implements ScreenerFilterNodeDto {}

    public sealed interface FilterValueDto permits SingleValueDto, ListValueDto, RangeValueDto, RelativeValueDto {}
    public record SingleValueDto(String kind, String value) implements FilterValueDto {}
    public record ListValueDto(String kind, List<String> values) implements FilterValueDto {}
    public record RangeValueDto(String kind, String min, String max) implements FilterValueDto {}
    public record RelativeValueDto(String kind, String unit, String comparator, double value) implements FilterValueDto {}

    public record ScreenerResultRowDto(
        long instrumentId,
        String symbol,
        String sector,
        String timeframe,
        Double latestClose,
        String currentCandleType,
        String latestPivotType,
        String previousPivotType,
        String smaAlignmentSummary,
        String crossoverSummary,
        String signalSummary,
        String updatedAt
    ) {}
}
