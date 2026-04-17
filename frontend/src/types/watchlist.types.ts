export interface WatchlistDefinitionDto {
  watchlistId: string;
  userId: string;
  name: string;
  exchangeCode: string;
  watchlistType: string;
  ruleEngineType?: string | null;
  createdAt: string;
  updatedAt: string;
}
export interface CreateWatchlistRequestDto {
  userId: string;
  name: string;
  exchangeCode: string;
  watchlistType?: string;
  ruleEngineType?: string | null;
}
export interface UpdateWatchlistRequestDto extends CreateWatchlistRequestDto {
  watchlistId: string;
}
export interface WatchlistItemDto {
  watchlistItemId: string;
  watchlistId: string;
  instrumentId: number;
  symbol?: string | null;
  note?: string | null;
  sourceRuleId?: string | null;
  createdAt: string;
}
export interface CreateWatchlistItemRequestDto { userId: string; instrumentId: number; note?: string | null; }
export interface UpdateWatchlistItemRequestDto { watchlistItemId: string; userId: string; note?: string | null; }
export interface WatchlistDetailDto { watchlist: WatchlistDefinitionDto; items: WatchlistItemDto[]; rules: WatchlistGenerationRuleDto[]; }
export interface WatchlistGenerationRuleDto {
  ruleId: string;
  watchlistId: string;
  userId: string;
  name: string;
  exchangeCode: string;
  ruleType: string;
  ruleDefinition: Record<string, unknown>;
  isEnabled: boolean;
  lastGeneratedAt?: string | null;
  createdAt: string;
  updatedAt: string;
}
export interface SaveWatchlistGenerationRuleRequestDto {
  userId: string;
  watchlistId: string;
  name: string;
  exchangeCode: string;
  ruleType: string;
  ruleDefinition: Record<string, unknown>;
  isEnabled?: boolean;
}
export interface UpdateWatchlistGenerationRuleRequestDto extends SaveWatchlistGenerationRuleRequestDto { ruleId: string; }
export interface GenerateWatchlistFromRuleResponseDto {
  ruleId: string;
  watchlistId: string;
  insertedCount: number;
  instrumentIds: number[];
  generatedAt: string;
}
export interface AlertRuleDto {
  alertRuleId: string;
  userId: string;
  exchangeCode: string;
  instrumentId: number;
  symbol?: string | null;
  ruleName: string;
  ruleType: string;
  status: string;
  sourceWatchlistId?: string | null;
  configJson?: string | null;
  createdAt: string;
  updatedAt: string;
}
export interface UpdateAlertRuleRequestDto {
  alertRuleId: string;
  userId: string;
  ruleName: string;
  ruleType: string;
  status: string;
  configJson?: string | null;
}
