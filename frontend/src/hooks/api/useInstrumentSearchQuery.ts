import { useQuery } from '@tanstack/react-query';
import { apiPost } from '../../lib/apiClient';
import type { InstrumentSearchRequestDto, InstrumentSearchResponseDto } from '../../types/instrument.types';

export function useInstrumentSearchQuery(request: InstrumentSearchRequestDto) {
  return useQuery({
    queryKey: ['instrument-search', request],
    queryFn: () => apiPost<InstrumentSearchResponseDto>('/api/analytics/instruments/search', request),
  });
}
