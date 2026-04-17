import { useQuery } from '@tanstack/react-query';
import apiClient from '../../lib/apiClient';
import type { WatchlistAuditTimelineDto, AlertAuditTimelineDto } from '../../types/audit.types';

export function useWatchlistAuditTimeline(watchlistId?: number) {
  return useQuery({
    queryKey: ['watchlist-audit', watchlistId],
    enabled: !!watchlistId,
    queryFn: async () => (await apiClient.get<WatchlistAuditTimelineDto>(`/api/audit/watchlists/${watchlistId}`)).data,
  });
}

export function useAlertAuditTimeline(alertRuleId?: number) {
  return useQuery({
    queryKey: ['alert-audit', alertRuleId],
    enabled: !!alertRuleId,
    queryFn: async () => (await apiClient.get<AlertAuditTimelineDto>(`/api/audit/alerts/${alertRuleId}`)).data,
  });
}
