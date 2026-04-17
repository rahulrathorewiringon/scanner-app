import { useQuery } from '@tanstack/react-query';
import { apiGet } from '../../lib/apiClient';
import type { MultiTimeframeChartsDto } from '../../types/chart.types';
import type { ExchangeCode } from '../../types/common.types';

export function useMultiTimeframeChartsQuery(params: { exchangeCode: ExchangeCode; instrumentId: number }) {
  return useQuery({
    queryKey: ['mtf-charts', params],
    queryFn: () => apiGet<MultiTimeframeChartsDto>(`/api/instruments/${params.instrumentId}/charts`, {
      exchangeCode: params.exchangeCode,
      timeframes: 'week,day,hour',
      includeSma: true,
      includePivots: true,
      includePivotCandles: false,
    }),
  });
}
