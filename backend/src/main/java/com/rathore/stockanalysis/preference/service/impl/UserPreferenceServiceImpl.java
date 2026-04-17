package com.rathore.stockanalysis.preference.service.impl;

import com.rathore.stockanalysis.authz.service.AuthorizationService;
import com.rathore.stockanalysis.preference.dto.*;
import com.rathore.stockanalysis.preference.repository.UserPreferenceRepository;
import com.rathore.stockanalysis.preference.service.UserPreferenceService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class UserPreferenceServiceImpl implements UserPreferenceService {
    private final UserPreferenceRepository repository;
    private final AuthorizationService authorizationService;
    public UserPreferenceServiceImpl(UserPreferenceRepository repository, AuthorizationService authorizationService) { this.repository = repository; this.authorizationService = authorizationService; }
    private long key(UUID id){ return Math.abs(id.getMostSignificantBits()); }
    public List<SavedScreenerDefinitionDto> listSavedScreeners(String userId){ return repository.listSavedScreeners(userId); }
    public List<SavedScreenerDefinitionDto> listSharedScreeners(String userId){ return repository.listSharedScreeners(userId); }
    public SavedScreenerDefinitionDto saveScreener(SaveScreenerRequestDto request){ return repository.saveScreener(request); }
    public SavedScreenerDefinitionDto updateScreener(UpdateScreenerRequestDto request){ authorizationService.requireScreenerAccess(request.userId(), key(request.screenerId()), "EDIT"); return repository.updateScreener(request); }
    public void deleteSavedScreener(UUID screenerId, String userId){ authorizationService.requireScreenerAccess(userId, key(screenerId), "EDIT"); repository.deleteSavedScreener(screenerId, userId); }
    public List<SavedScreenerTagDto> listScreenerTags(UUID screenerId, String actorUserId){ authorizationService.requireScreenerAccess(actorUserId, key(screenerId), "VIEW"); return repository.listScreenerTags(screenerId, actorUserId); }
    public List<SavedScreenerTagDto> replaceScreenerTags(UUID screenerId, String actorUserId, List<String> tags){ authorizationService.requireScreenerAccess(actorUserId, key(screenerId), "EDIT"); return repository.replaceScreenerTags(screenerId, actorUserId, tags); }
    public List<SavedScreenerShareDto> listScreenerShares(UUID screenerId, String actorUserId){ authorizationService.requireScreenerAccess(actorUserId, key(screenerId), "EDIT"); return repository.listScreenerShares(screenerId, actorUserId); }
    public SavedScreenerShareDto saveScreenerShare(SaveScreenerShareRequestDto request){ authorizationService.requireScreenerAccess(request.ownerUserId(), key(request.screenerId()), "EDIT"); return repository.saveScreenerShare(request); }
    public SavedScreenerShareDto updateScreenerSharePermission(SaveScreenerShareRequestDto request){ authorizationService.requireScreenerAccess(request.ownerUserId(), key(request.screenerId()), "EDIT"); return repository.updateScreenerSharePermission(request); }
    public void deleteScreenerShare(UUID screenerId, String actorUserId, String sharedWithUserId){ authorizationService.requireScreenerAccess(actorUserId, key(screenerId), "EDIT"); repository.deleteScreenerShare(screenerId, actorUserId, sharedWithUserId); }
    public List<WorkspaceLayoutPresetDto> listLayoutPresets(String userId){ return repository.listLayoutPresets(userId); }
    public List<WorkspaceLayoutPresetDto> listSharedLayoutPresets(String userId){ return repository.listSharedLayoutPresets(userId); }
    public WorkspaceLayoutPresetDto saveLayoutPreset(SaveWorkspaceLayoutPresetRequestDto request){ return repository.saveLayoutPreset(request); }
    public WorkspaceLayoutPresetDto updateLayoutPreset(UpdateWorkspaceLayoutPresetRequestDto request){ authorizationService.requireWorkspacePresetAccess(request.userId(), key(request.presetId()), "EDIT"); return repository.updateLayoutPreset(request); }
    public WorkspaceLayoutPresetDto markDefaultLayoutPreset(UUID presetId, String userId){ authorizationService.requireWorkspacePresetAccess(userId, key(presetId), "EDIT"); repository.markDefaultLayoutPreset(presetId, userId); return repository.listLayoutPresets(userId).stream().filter(p -> p.presetId().equals(presetId)).findFirst().orElse(null); }
    public WorkspaceLayoutPresetDto markFavoriteLayoutPreset(UUID presetId, String userId, boolean favorite){ authorizationService.requireWorkspacePresetAccess(userId, key(presetId), "EDIT"); repository.markFavoriteLayoutPreset(presetId, userId, favorite); return repository.listLayoutPresets(userId).stream().filter(p -> p.presetId().equals(presetId)).findFirst().orElse(null); }
    public void deleteLayoutPreset(UUID presetId, String userId){ authorizationService.requireWorkspacePresetAccess(userId, key(presetId), "EDIT"); repository.deleteLayoutPreset(presetId, userId); }
    public List<WorkspaceLayoutPresetShareDto> listLayoutPresetShares(UUID presetId, String actorUserId){ authorizationService.requireWorkspacePresetAccess(actorUserId, key(presetId), "EDIT"); return repository.listLayoutPresetShares(presetId, actorUserId); }
    public WorkspaceLayoutPresetShareDto saveLayoutPresetShare(SaveWorkspaceLayoutPresetShareRequestDto request){ authorizationService.requireWorkspacePresetAccess(request.ownerUserId(), key(request.presetId()), "EDIT"); return repository.saveLayoutPresetShare(request); }
    public WorkspaceLayoutPresetShareDto updateLayoutPresetSharePermission(SaveWorkspaceLayoutPresetShareRequestDto request){ authorizationService.requireWorkspacePresetAccess(request.ownerUserId(), key(request.presetId()), "EDIT"); return repository.updateLayoutPresetSharePermission(request); }
    public void deleteLayoutPresetShare(UUID presetId, String actorUserId, String sharedWithUserId){ authorizationService.requireWorkspacePresetAccess(actorUserId, key(presetId), "EDIT"); repository.deleteLayoutPresetShare(presetId, actorUserId, sharedWithUserId); }
    public ScreenerBulkActionResponseDto applyBulkAction(ScreenerBulkActionRequestDto request){ return repository.applyBulkAction(request); }
}
