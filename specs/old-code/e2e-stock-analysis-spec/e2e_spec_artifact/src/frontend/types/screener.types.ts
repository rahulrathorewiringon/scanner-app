import type { ExchangeCode, Timeframe } from "./common.types";

export interface ScreenerFilterMetadataDto {
  exchangeCode: ExchangeCode;
  timeframes: Timeframe[];
  fields: Array<{
    group: "instrument" | "sma" | "pivot" | "candle" | "signal";
    key: string;
    label: string;
    operators: string[];
    valueType: "single" | "list" | "range" | "relative";
    options?: Array<{ value: string; label: string }>;
  }>;
}

export type ScreenerFilterNode = ScreenerFilterGroupDto | ScreenerConditionDto;

export interface ScreenerFilterGroupDto {
  type: "group";
  id: string;
  operator: "AND" | "OR";
  enabled: boolean;
  children: ScreenerFilterNode[];
}

export interface ScreenerConditionDto {
  type: "condition";
  id: string;
  enabled: boolean;
  fieldGroup: "instrument" | "sma" | "pivot" | "candle" | "signal";
  field: string;
  timeframe?: Timeframe | "current";
  operator: string;
  value:
    | { kind: "single"; value: string | number | boolean | null }
    | { kind: "list"; values: Array<string | number | boolean> }
    | { kind: "range"; min?: string | number | null; max?: string | number | null }
    | { kind: "relative"; unit: "atr" | "percent" | "bars"; comparator?: string; value: number };
}

export interface ScreenerRunRequestDto {
  exchangeCode: ExchangeCode;
  tradeDate: string;
  defaultTimeframe: Timeframe;
  filterTree: ScreenerFilterGroupDto;
  pagination?: { pageIndex: number; pageSize: number };
  sort?: Array<{ field: string; direction: "asc" | "desc" }>;
}

export interface ScreenerResultRowDto {
  instrumentId: number;
  symbol: string;
  sector?: string | null;
  timeframe: Timeframe;
  latestClose?: number | null;
  currentCandleType?: string | null;
  latestPivotType?: string | null;
  previousPivotType?: string | null;
  smaAlignmentSummary?: string | null;
  crossoverSummary?: string | null;
  signalSummary?: string | null;
  updatedAt?: string | null;
}

export interface ScreenerRunResponseDto {
  rows: ScreenerResultRowDto[];
  totalRows: number;
  pageIndex: number;
  pageSize: number;
}
