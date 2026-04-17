import { useMutation } from '@tanstack/react-query';
import { apiPost } from '../../lib/apiClient';
import type { ScreenerRunRequestDto, ScreenerCountResponseDto } from '../../types/screener.types';

export function useScreenerCountMutation() {
  return useMutation({
    mutationFn: (request: ScreenerRunRequestDto) => apiPost<ScreenerCountResponseDto>('/api/screener/count', request),
  });
}
