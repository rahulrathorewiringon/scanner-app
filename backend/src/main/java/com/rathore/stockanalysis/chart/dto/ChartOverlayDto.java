package com.rathore.stockanalysis.chart.dto;

import java.util.List;

public record ChartOverlayDto(SmaOverlay sma, List<PivotMarkerDto> pivots) {
    public record SmaOverlay(List<LinePointDto> sma5, List<LinePointDto> sma10, List<LinePointDto> sma20,
                             List<LinePointDto> sma50, List<LinePointDto> sma100, List<LinePointDto> sma200) {}
}
