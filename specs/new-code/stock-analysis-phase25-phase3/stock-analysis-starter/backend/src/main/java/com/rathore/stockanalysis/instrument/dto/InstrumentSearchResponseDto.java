package com.rathore.stockanalysis.instrument.dto;

import java.util.List;

public record InstrumentSearchResponseDto(
        List<InstrumentRowDto> rows,
        long totalRows,
        int pageIndex,
        int pageSize
) {}
