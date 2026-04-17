export interface WatchlistAuditEventDto {
  auditEventId: number;
  watchlistId: number;
  userId: string;
  eventType: string;
  entityType: string;
  entityId?: string | null;
  beforeJson?: Record<string, unknown> | null;
  afterJson?: Record<string, unknown> | null;
  eventTs: string;
}
export interface AlertAuditEventDto {
  auditEventId: number;
  alertRuleId: number;
  userId: string;
  eventType: string;
  beforeJson?: Record<string, unknown> | null;
  afterJson?: Record<string, unknown> | null;
  eventTs: string;
}
export interface WatchlistAuditTimelineDto {
  watchlistId: number;
  events: WatchlistAuditEventDto[];
}
export interface AlertAuditTimelineDto {
  alertRuleId: number;
  events: AlertAuditEventDto[];
}
