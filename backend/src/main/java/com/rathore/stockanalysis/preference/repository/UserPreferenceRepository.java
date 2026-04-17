package com.rathore.stockanalysis.preference.repository;

import com.rathore.stockanalysis.preference.dto.*;
import java.util.List;
import java.util.UUID;

public interface UserPreferenceRepository {
    List<SavedScreenerDefinitionDto> listSavedScreeners(String userId);
    List<SavedScreenerDefinitionDto> listSharedScreeners(String userId);
    SavedScreenerDefinitionDto saveScreener(SaveScreenerRequestDto request);
    SavedScreenerDefinitionDto updateScreener(UpdateScreenerRequestDto request);
    void deleteSavedScreener(UUID screenerId, String userId);
    List<SavedScreenerTagDto> listScreenerTags(UUID screenerId, String actorUserId);
    List<SavedScreenerTagDto> replaceScreenerTags(UUID screenerId, String actorUserId, List<String> tags);
    List<SavedScreenerShareDto> listScreenerShares(UUID screenerId, String ownerUserId);
    SavedScreenerShareDto saveScreenerShare(SaveScreenerShareRequestDto request);
    SavedScreenerShareDto updateScreenerSharePermission(SaveScreenerShareRequestDto request);
    void deleteScreenerShare(UUID screenerId, String ownerUserId, String sharedWithUserId);
    List<WorkspaceLayoutPresetDto> listLayoutPresets(String userId);
    List<WorkspaceLayoutPresetDto> listSharedLayoutPresets(String userId);
    WorkspaceLayoutPresetDto saveLayoutPreset(SaveWorkspaceLayoutPresetRequestDto request);
    WorkspaceLayoutPresetDto updateLayoutPreset(UpdateWorkspaceLayoutPresetRequestDto request);
    void markDefaultLayoutPreset(UUID presetId, String userId);
    void markFavoriteLayoutPreset(UUID presetId, String userId, boolean favorite);
    void deleteLayoutPreset(UUID presetId, String userId);
    List<WorkspaceLayoutPresetShareDto> listLayoutPresetShares(UUID presetId, String ownerUserId);
    WorkspaceLayoutPresetShareDto saveLayoutPresetShare(SaveWorkspaceLayoutPresetShareRequestDto request);
    WorkspaceLayoutPresetShareDto updateLayoutPresetSharePermission(SaveWorkspaceLayoutPresetShareRequestDto request);
    void deleteLayoutPresetShare(UUID presetId, String ownerUserId, String sharedWithUserId);
    ScreenerBulkActionResponseDto applyBulkAction(ScreenerBulkActionRequestDto request);
}
