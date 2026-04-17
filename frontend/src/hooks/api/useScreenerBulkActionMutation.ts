import { useMutation } from '@tanstack/react-query';
import { apiPost } from '../../lib/apiClient';
import type { ScreenerBulkActionRequestDto, ScreenerBulkActionResponseDto } from '../../types/screener.types';

export function useScreenerBulkActionMutation() {
  return useMutation({
    mutationFn: (body: ScreenerBulkActionRequestDto) => apiPost<ScreenerBulkActionResponseDto>('/api/screener/bulk-actions', body),
  });
}
