import { useQuery } from '@tanstack/react-query';
import { apiGet } from '../../lib/apiClient';
import type { ScreenerFilterMetadataDto } from '../../types/screener.types';
import type { ExchangeCode } from '../../types/common.types';

export function useScreenerFilterMetadataQuery(exchangeCode: ExchangeCode) {
  return useQuery({
    queryKey: ['screener-filter-metadata', exchangeCode],
    queryFn: () => apiGet<ScreenerFilterMetadataDto>('/api/screener/filter-metadata', { exchangeCode }),
  });
}
