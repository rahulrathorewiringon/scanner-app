package com.rathore.stockanalysis.screener.service.impl;

import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import com.rathore.stockanalysis.screener.repository.ScreenerQueryRepository;
import com.rathore.stockanalysis.screener.service.ScreenerService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ScreenerServiceImpl implements ScreenerService {
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;
    private final ScreenerQueryRepository screenerQueryRepository;

    public ScreenerServiceImpl(ExchangeSchemaRegistry exchangeSchemaRegistry,
                               ScreenerQueryRepository screenerQueryRepository) {
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
        this.screenerQueryRepository = screenerQueryRepository;
    }

    @Override
    public ScreenerDtos.ScreenerFilterMetadataDto getFilterMetadata(String exchangeCode) {
        exchangeSchemaRegistry.resolve(exchangeCode);
        return new ScreenerDtos.ScreenerFilterMetadataDto(exchangeCode, List.of("hour", "day", "week"), List.of(
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("instrument", "symbol", "Symbol", List.of("eq", "contains"), "single", List.of()),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("instrument", "sector", "Sector", List.of("eq", "in", "contains"), "single", List.of()),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("signal", "trendState", "Trend State", List.of("eq", "in"), "single", options("UPTREND", "DOWNTREND", "SIDEWAYS")),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("candle", "currentCandleType", "Current Candle Pattern", List.of("eq", "in"), "single", options("BOTTOM_TAIL", "TOPPING_TAIL", "STRONG_BODY", "NEUTRAL")),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("pivot", "latestPivotType", "Latest Pivot Type", List.of("eq", "in"), "single", options("PH", "PL")),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("pivot", "previousPivotType", "Previous Pivot Type", List.of("eq", "in"), "single", options("PH", "PL")),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("sma", "smaStructure", "SMA Structure", List.of("eq", "in"), "single", options("BULL_STACK_5_10_20", "BEAR_STACK_5_10_20", "MIXED_5_10_20")),
                new ScreenerDtos.ScreenerFilterMetadataDto.FieldDef("instrument", "latestClose", "Latest Close", List.of("eq", "gt", "gte", "lt", "lte"), "single", List.of())
        ));
    }

    @Override
    public ScreenerDtos.ScreenerCountResponseDto count(ScreenerDtos.ScreenerRunRequestDto request) {
        exchangeSchemaRegistry.resolve(request.exchangeCode());
        return new ScreenerDtos.ScreenerCountResponseDto(screenerQueryRepository.count(request.exchangeCode(), request));
    }

    @Override
    public ScreenerDtos.ScreenerRunResponseDto run(ScreenerDtos.ScreenerRunRequestDto request) {
        exchangeSchemaRegistry.resolve(request.exchangeCode());
        return screenerQueryRepository.run(request.exchangeCode(), request);
    }

    private static List<Map<String, String>> options(String... values) {
        return java.util.Arrays.stream(values)
                .map(v -> Map.of("value", v, "label", v))
                .toList();
    }
}
