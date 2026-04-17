import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import apiClient from '../../lib/apiClient';

export function useSharedWorkspacePresets(userId: string) {
  return useQuery({
    queryKey: ['shared-workspace-presets', userId],
    queryFn: async () => (await apiClient.get('/api/workspace/shared-layout-presets', { params: { userId } })).data,
  });
}

export function useUpdateWorkspacePresetSharePermission() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: async (payload: { presetId: number; actorUserId: string; sharedWithUserId: string; permissionCode: string }) =>
      (await apiClient.put(`/api/workspace/layout-presets/${payload.presetId}/shares`, payload)).data,
    onSuccess: () => qc.invalidateQueries({ queryKey: ['shared-workspace-presets'] }),
  });
}
