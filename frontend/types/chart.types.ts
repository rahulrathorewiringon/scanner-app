import type { ExchangeCode, Timeframe } from "./common.types";

export interface ChartContextDto {
  instrumentId: number;
  symbol: string;
  exchangeCode: ExchangeCode;
  selectedTimeframes: Timeframe[];
}

export interface ChartPaneStateDto {
  timeframe: Timeframe;
  visibleFrom?: string | null;
  visibleTo?: string | null;
  crosshairTime?: string | null;
  showSma: boolean;
  showPivots: boolean;
  showSupportResistance: boolean;
}
