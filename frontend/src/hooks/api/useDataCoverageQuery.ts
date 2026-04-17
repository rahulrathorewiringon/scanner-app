import { useQuery } from '@tanstack/react-query';
import { apiGet } from '../../lib/apiClient';
import type { DataCoverageDto } from '../../types/dashboard.types';
import type { ExchangeCode } from '../../types/common.types';

export function useDataCoverageQuery(exchangeCode: ExchangeCode) {
  return useQuery({
    queryKey: ['data-coverage', exchangeCode],
    queryFn: () => apiGet<DataCoverageDto>('/api/analytics/data-coverage', { exchangeCode }),
  });
}
