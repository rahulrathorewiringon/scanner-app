import type { ExchangeCode, Timeframe, TrendState } from './common.types';

export interface InstrumentRowDto {
  instrumentId: number;
  symbol: string;
  tradingSymbol?: string | null;
  instrumentType: string;
  sector?: string | null;
  exchangeCode: ExchangeCode;
  latestTradeDate?: string | null;
  chartDataExists: boolean;
  chartTimeframesAvailable: Timeframe[];
  bootstrapStatus: string;
  chartDataStatus?: string | null;
  trendState?: TrendState | null;
  currentCandlePattern?: string | null;
  latestPivotType?: string | null;
  latestTrendPivotType?: string | null;
  smaStructure?: string | null;
  updatedAt?: string | null;
}

export interface InstrumentSearchRequestDto {
  exchangeCode: ExchangeCode;
  tradeDate: string;
  trendFilter?: 'ALL' | TrendState;
  timeframeFilter?: Timeframe[];
  sector?: string | null;
  symbolQuery?: string | null;
  candleType?: string | null;
  pivotType?: string | null;
  smaStructure?: string | null;
  pageIndex: number;
  pageSize: number;
  sort: Array<{ field: string; direction: 'asc' | 'desc' }>;
}

export interface InstrumentSearchResponseDto {
  rows: InstrumentRowDto[];
  totalRows: number;
  pageIndex: number;
  pageSize: number;
}

export interface PivotEventDto {
  timeframe: Timeframe;
  barStartTs: string;
  tfId: number;
  pivotType?: string | null;
  pivotConfirmed?: boolean;
  pivotPrice?: number | null;
  trendPivotType?: string | null;
}

export interface LatestPriceSnapshotDto {
  timeframe: Timeframe;
  tradeDate: string;
  tfId: number;
  barStartTs: string;
  open: number;
  high: number;
  low: number;
  close: number;
  volume?: number | null;
}

export interface InstrumentSummaryDto {
  identity: {
    instrumentId: number;
    symbol: string;
    tradingSymbol?: string | null;
    exchangeCode: ExchangeCode;
    instrumentType?: string;
    sector?: string | null;
    industry?: string | null;
  };
  dataAvailability: {
    chartDataExists: boolean;
    bootstrapStatus: string;
    chartDataStatus?: string | null;
    chartTimeframesAvailable: Timeframe[];
    chartFromDate?: string | null;
    chartToDate?: string | null;
  };
  latestPrices?: {
    week?: LatestPriceSnapshotDto | null;
    day?: LatestPriceSnapshotDto | null;
    hour?: LatestPriceSnapshotDto | null;
  };
  trend: {
    state?: TrendState | null;
    timeframe?: Timeframe | null;
    strength?: string | null;
    source?: string | null;
  };
  smaStructure?: {
    week?: string | null;
    day?: string | null;
    hour?: string | null;
    crossoverState?: string | null;
    slopeState?: string | null;
  };
  pivots?: {
    latestPivotType?: string | null;
    latestTrendPivotType?: string | null;
    previousPivotType?: string | null;
    recentSequence?: PivotEventDto[];
  };
  candleAnalysis?: {
    currentPattern?: string | null;
    previousPattern?: string | null;
    bodyPct?: number | null;
    upperWickPct?: number | null;
    lowerWickPct?: number | null;
    rangeToAtr?: number | null;
  };
}
