package com.rathore.stockanalysis.screener.service;

import com.rathore.stockanalysis.common.exchange.ExchangeSchemaRegistry;
import com.rathore.stockanalysis.screener.dto.ScreenerDtos;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScreenerServiceImpl implements ScreenerService {
    private final ExchangeSchemaRegistry exchangeSchemaRegistry;

    public ScreenerServiceImpl(ExchangeSchemaRegistry exchangeSchemaRegistry) {
        this.exchangeSchemaRegistry = exchangeSchemaRegistry;
    }

    @Override
    public ScreenerDtos.ScreenerFilterMetadataDto getFilterMetadata(String exchangeCode) {
        exchangeSchemaRegistry.resolve(exchangeCode);
        return new ScreenerDtos.ScreenerFilterMetadataDto(exchangeCode, List.of("hour", "day", "week"), List.of());
    }

    @Override
    public ScreenerDtos.ScreenerCountResponseDto count(ScreenerDtos.ScreenerRunRequestDto request) {
        exchangeSchemaRegistry.resolve(request.exchangeCode());
        return new ScreenerDtos.ScreenerCountResponseDto(0);
    }

    @Override
    public ScreenerDtos.ScreenerRunResponseDto run(ScreenerDtos.ScreenerRunRequestDto request) {
        exchangeSchemaRegistry.resolve(request.exchangeCode());
        int pageIndex = request.pagination() != null ? request.pagination().pageIndex() : 0;
        int pageSize = request.pagination() != null ? request.pagination().pageSize() : 50;
        return new ScreenerDtos.ScreenerRunResponseDto(List.of(), 0, pageIndex, pageSize);
    }
}
