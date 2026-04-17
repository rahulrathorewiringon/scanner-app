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
  };
  trend: {
    state?: TrendState | null;
    timeframe?: Timeframe | null;
  };
  smaStructure?: {
    week?: string | null;
    day?: string | null;
    hour?: string | null;
  };
  pivots?: {
    latestPivotType?: string | null;
    latestTrendPivotType?: string | null;
  };
}
