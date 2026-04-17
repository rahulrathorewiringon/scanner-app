import type { ExchangeCode, Timeframe } from './common.types';

export interface DashboardOverviewDto {
  exchangeCode: ExchangeCode;
  tradeDate: string;
  timeframe: Timeframe;
  totalActiveInstruments: number;
  instrumentsWithData: number;
  uptrendCount: number;
  downtrendCount: number;
  sidewaysCount: number;
  latestChartToDate?: string | null;
  latestBootstrapCompletedAt?: string | null;
  timeframeCoverage?: {
    hourCount: number;
    dayCount: number;
    weekCount: number;
  };
  sectorBuckets?: Array<{
    sector: string;
    total: number;
    uptrend: number;
    downtrend: number;
    sideways: number;
  }>;
}
export interface DataCoverageDto {
  exchangeCode: ExchangeCode;
  totalActiveInstruments: number;
  chartDataExistsCount: number;
  staleCount: number;
  rebuildRequiredCount: number;
  byBootstrapStatus: Array<{ status: string; count: number }>;
  byChartDataStatus: Array<{ status: string; count: number }>;
  byTimeframeAvailability: { hour: number; day: number; week: number };
}
