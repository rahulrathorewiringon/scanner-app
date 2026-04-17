package com.rathore.stockanalysis.preference.service;

import com.rathore.stockanalysis.preference.dto.*;
import java.util.List;
import java.util.UUID;

public interface UserPreferenceService {
    List<SavedScreenerDefinitionDto> listSavedScreeners(String userId);
    List<SavedScreenerDefinitionDto> listSharedScreeners(String userId);
    SavedScreenerDefinitionDto saveScreener(SaveScreenerRequestDto request);
    SavedScreenerDefinitionDto updateScreener(UpdateScreenerRequestDto request);
    void deleteSavedScreener(UUID screenerId, String userId);
    List<SavedScreenerTagDto> listScreenerTags(UUID screenerId, String actorUserId);
    List<SavedScreenerTagDto> replaceScreenerTags(UUID screenerId, String actorUserId, List<String> tags);
    List<SavedScreenerShareDto> listScreenerShares(UUID screenerId, String actorUserId);
    SavedScreenerShareDto saveScreenerShare(SaveScreenerShareRequestDto request);
    SavedScreenerShareDto updateScreenerSharePermission(SaveScreenerShareRequestDto request);
    void deleteScreenerShare(UUID screenerId, String actorUserId, String sharedWithUserId);
    List<WorkspaceLayoutPresetDto> listLayoutPresets(String userId);
    List<WorkspaceLayoutPresetDto> listSharedLayoutPresets(String userId);
    WorkspaceLayoutPresetDto saveLayoutPreset(SaveWorkspaceLayoutPresetRequestDto request);
    WorkspaceLayoutPresetDto updateLayoutPreset(UpdateWorkspaceLayoutPresetRequestDto request);
    WorkspaceLayoutPresetDto markDefaultLayoutPreset(UUID presetId, String userId);
    WorkspaceLayoutPresetDto markFavoriteLayoutPreset(UUID presetId, String userId, boolean favorite);
    void deleteLayoutPreset(UUID presetId, String userId);
    List<WorkspaceLayoutPresetShareDto> listLayoutPresetShares(UUID presetId, String actorUserId);
    WorkspaceLayoutPresetShareDto saveLayoutPresetShare(SaveWorkspaceLayoutPresetShareRequestDto request);
    WorkspaceLayoutPresetShareDto updateLayoutPresetSharePermission(SaveWorkspaceLayoutPresetShareRequestDto request);
    void deleteLayoutPresetShare(UUID presetId, String actorUserId, String sharedWithUserId);
    ScreenerBulkActionResponseDto applyBulkAction(ScreenerBulkActionRequestDto request);
}
