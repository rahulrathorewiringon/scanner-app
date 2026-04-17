import type { ExchangeCode, TrendState } from "./common.types";

export interface InstrumentRowDto {
  instrumentId: number;
  symbol: string;
  exchangeCode: ExchangeCode;
  trendState?: TrendState | null;
}
