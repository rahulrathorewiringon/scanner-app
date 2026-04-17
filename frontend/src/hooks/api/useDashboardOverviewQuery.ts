import { useQuery } from '@tanstack/react-query';
import { apiGet } from '../../lib/apiClient';
import type { DashboardOverviewDto } from '../../types/dashboard.types';
import type { ExchangeCode, Timeframe } from '../../types/common.types';

export function useDashboardOverviewQuery(params: { exchangeCode: ExchangeCode; tradeDate: string; timeframe: Timeframe }) {
  return useQuery({
    queryKey: ['dashboard-overview', params],
    queryFn: () => apiGet<DashboardOverviewDto>('/api/analytics/dashboard-overview', params),
  });
}
