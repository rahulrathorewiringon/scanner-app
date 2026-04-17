import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { apiDelete, apiGet, apiPost, apiPut } from '../../lib/apiClient';
import type { SaveScreenerRequestDto, SavedScreenerDefinition, UpdateScreenerRequestDto } from '../../types/screener.types';

export function useSavedScreenersQuery(userId: string) {
  return useQuery({ queryKey: ['saved-screeners', userId], queryFn: () => apiGet<SavedScreenerDefinition[]>('/api/screener/saved-definitions', { userId }), enabled: !!userId });
}
export function useSaveScreenerMutation() {
  const qc = useQueryClient();
  return useMutation({ mutationFn: (body: SaveScreenerRequestDto) => apiPost<SavedScreenerDefinition>('/api/screener/saved-definitions', body), onSuccess: (_d, vars) => qc.invalidateQueries({ queryKey: ['saved-screeners', vars.userId] }) });
}
export function useUpdateSavedScreenerMutation() {
  const qc = useQueryClient();
  return useMutation({ mutationFn: (body: UpdateScreenerRequestDto) => apiPut<SavedScreenerDefinition>(`/api/screener/saved-definitions/${body.screenerId}`, body), onSuccess: (_d, vars) => qc.invalidateQueries({ queryKey: ['saved-screeners', vars.userId] }) });
}
export function useDeleteSavedScreenerMutation(userId: string) {
  const qc = useQueryClient();
  return useMutation({ mutationFn: (screenerId: string) => apiDelete<{ deleted: boolean }>('/api/screener/saved-definitions/' + screenerId, { userId }), onSuccess: () => qc.invalidateQueries({ queryKey: ['saved-screeners', userId] }) });
}
