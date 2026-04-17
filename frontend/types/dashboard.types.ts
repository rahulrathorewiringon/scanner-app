import type { ExchangeCode, Timeframe } from "./common.types";

export interface DashboardOverviewDto {
  exchangeCode: ExchangeCode;
  tradeDate: string;
  timeframe: Timeframe;
  totalActiveInstruments: number;
  instrumentsWithData: number;
  uptrendCount: number;
  downtrendCount: number;
  sidewaysCount: number;
}
