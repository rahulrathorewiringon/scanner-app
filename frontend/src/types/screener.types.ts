import type { ExchangeCode } from './common.types';

export interface ScreenerFieldOption { value: string; label: string; }
export interface ScreenerFieldDef { group: 'instrument' | 'sma' | 'pivot' | 'candle' | 'signal'; key: string; label: string; operators: string[]; valueType: 'single' | 'list' | 'range' | 'relative'; options?: ScreenerFieldOption[]; }
export interface ScreenerFilterMetadataDto { exchangeCode: string; timeframes: string[]; fields: ScreenerFieldDef[]; }
export type ScreenerValue = { kind: 'single'; value: string | number | boolean | null } | { kind: 'list'; values: Array<string | number | boolean> } | { kind: 'range'; min?: number | string | null; max?: number | string | null } | { kind: 'relative'; unit: 'atr' | 'percent' | 'bars'; value: number };
export interface ScreenerConditionNodeDto { type: 'condition'; id: string; enabled: boolean; fieldGroup: 'instrument' | 'sma' | 'pivot' | 'candle' | 'signal'; field: string; timeframe: 'current' | 'hour' | 'day' | 'week'; operator: string; value: ScreenerValue; }
export interface ScreenerFilterGroupDto { type: 'group'; id: string; operator: 'AND' | 'OR'; enabled: boolean; children: Array<ScreenerFilterNodeDto>; }
export type ScreenerFilterNodeDto = ScreenerConditionNodeDto | ScreenerFilterGroupDto;
export interface ScreenerSortSpec { field: 'symbol' | 'latestClose' | 'currentCandleType' | 'latestPivotType' | 'updatedAt'; direction: 'asc' | 'desc'; }
export interface ScreenerRunRequestDto { exchangeCode: ExchangeCode; tradeDate: string; defaultTimeframe: 'hour' | 'day' | 'week'; filterTree: ScreenerFilterGroupDto; pagination: { pageIndex: number; pageSize: number }; sort: ScreenerSortSpec[]; }
export interface ScreenerResultRowDto { instrumentId: number; symbol: string; sector?: string | null; timeframe: string; latestClose?: number | null; currentCandleType?: string | null; latestPivotType?: string | null; previousPivotType?: string | null; smaAlignmentSummary?: string | null; signalSummary?: string | null; updatedAt?: string | null; }
export interface ScreenerRunResponseDto { rows: ScreenerResultRowDto[]; totalRows: number; pageIndex: number; pageSize: number; }
export interface ScreenerCountResponseDto { count: number; }
export interface SavedScreenerDefinition { screenerId: string; userId: string; name: string; exchangeCode: ExchangeCode; tradeDate: string; defaultTimeframe: 'hour' | 'day' | 'week'; filterTree: ScreenerFilterGroupDto; sortSpec: ScreenerSortSpec[]; pageSize: number; createdAt: string; updatedAt: string; }
export interface SaveScreenerRequestDto { userId: string; name: string; exchangeCode: ExchangeCode; tradeDate: string; defaultTimeframe: 'hour' | 'day' | 'week'; filterTree: ScreenerFilterGroupDto; sortSpec: ScreenerSortSpec[]; pageSize: number; }
export interface UpdateScreenerRequestDto extends SaveScreenerRequestDto { screenerId: string; }
export interface SavedScreenerTagDto { screenerId: string; tag: string; createdAt: string; }
export interface SavedScreenerShareDto { shareId: string; screenerId: string; ownerUserId: string; sharedWithUserId: string; permission: string; createdAt: string; }
export interface SaveScreenerShareRequestDto { screenerId: string; ownerUserId: string; sharedWithUserId: string; permission: string; }
export interface ScreenerBulkActionRequestDto { userId: string; actionType: 'ADD_TO_WATCHLIST' | 'CREATE_ALERT' | 'EXPORT_SELECTION'; instrumentIds: number[]; payload?: Record<string, unknown>; }
export interface ScreenerBulkActionResponseDto { actionId: string; actionType: string; acceptedCount: number; message: string; domainEntityType?: string | null; domainEntityId?: string | null; }
