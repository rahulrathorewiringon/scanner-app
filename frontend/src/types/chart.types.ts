import type { ExchangeCode, Timeframe } from './common.types';

export interface ChartCandleDto {
  barStartTs: string;
  barEndTs: string;
  tradeDate: string;
  tfId: number;
  open: number;
  high: number;
  low: number;
  close: number;
  volume?: number | null;
}
export interface LinePointDto { time: string; value: number; }
export interface PivotMarkerDto { barStartTs: string; pivotType?: string | null; pivotConfirmed: boolean; pivotPrice?: number | null; trendPivotType?: string | null; }
export interface ChartOverlayDto {
  sma?: { sma5?: LinePointDto[]; sma10?: LinePointDto[]; sma20?: LinePointDto[]; sma50?: LinePointDto[]; sma100?: LinePointDto[]; sma200?: LinePointDto[]; } | null;
  pivots?: PivotMarkerDto[] | null;
}
export interface ChartSeriesDto { timeframe: Timeframe; candles: ChartCandleDto[]; }
export interface MultiTimeframeChartsDto {
  instrumentId: number;
  exchangeCode: ExchangeCode;
  symbol: string;
  series: { week?: ChartSeriesDto | null; day?: ChartSeriesDto | null; hour?: ChartSeriesDto | null; };
  overlays?: { week?: ChartOverlayDto | null; day?: ChartOverlayDto | null; hour?: ChartOverlayDto | null; };
}
export interface PivotTimelineEvent {
  timeframe: Timeframe;
  barStartTs: string;
  pivotType?: string | null;
  trendPivotType?: string | null;
  pivotPrice?: number | null;
}
