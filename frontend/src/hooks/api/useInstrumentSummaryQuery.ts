import { useQuery } from '@tanstack/react-query';
import { apiGet } from '../../lib/apiClient';
import type { InstrumentSummaryDto } from '../../types/instrument.types';
import type { ExchangeCode } from '../../types/common.types';

export function useInstrumentSummaryQuery(params: { exchangeCode: ExchangeCode; tradeDate: string; instrumentId: number }) {
  return useQuery({
    queryKey: ['instrument-summary', params],
    queryFn: () => apiGet<InstrumentSummaryDto>(`/api/instruments/${params.instrumentId}/summary`, {
      exchangeCode: params.exchangeCode,
      tradeDate: params.tradeDate,
    }),
  });
}
