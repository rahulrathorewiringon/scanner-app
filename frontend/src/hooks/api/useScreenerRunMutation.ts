import { useMutation } from '@tanstack/react-query';
import { apiPost } from '../../lib/apiClient';
import type { ScreenerRunRequestDto, ScreenerRunResponseDto } from '../../types/screener.types';

export function useScreenerRunMutation() {
  return useMutation({
    mutationFn: (request: ScreenerRunRequestDto) => apiPost<ScreenerRunResponseDto>('/api/screener/run', request),
  });
}
