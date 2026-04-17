package com.rathore.stockanalysis.preference.controller;

import com.rathore.stockanalysis.preference.dto.*;
import com.rathore.stockanalysis.preference.service.UserPreferenceService;
import jakarta.validation.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@Validated
public class UserPreferenceController {
    private final UserPreferenceService service;

    public UserPreferenceController(UserPreferenceService service) {
        this.service = service;
    }

    @GetMapping("/screener/saved-definitions")
    public List<SavedScreenerDefinitionDto> listSavedScreeners(@RequestParam @NotBlank String userId) { return service.listSavedScreeners(userId); }
    @GetMapping("/screener/shared-definitions")
    public List<SavedScreenerDefinitionDto> listSharedScreeners(@RequestParam @NotBlank String userId) { return service.listSharedScreeners(userId); }
    @PostMapping("/screener/saved-definitions")
    public SavedScreenerDefinitionDto saveScreener(@RequestBody SaveScreenerRequestDto request) { return service.saveScreener(request); }
    @PutMapping("/screener/saved-definitions/{screenerId}")
    public SavedScreenerDefinitionDto updateSavedScreener(@PathVariable UUID screenerId, @RequestBody UpdateScreenerRequestDto request) {
        return service.updateScreener(new UpdateScreenerRequestDto(screenerId, request.userId(), request.name(), request.exchangeCode(), request.tradeDate(), request.defaultTimeframe(), request.filterTree(), request.sortSpec(), request.pageSize()));
    }
    @DeleteMapping("/screener/saved-definitions/{screenerId}")
    public Map<String, Object> deleteSavedScreener(@PathVariable UUID screenerId, @RequestParam String userId) { service.deleteSavedScreener(screenerId, userId); return Map.of("deleted", true, "screenerId", screenerId); }

    @GetMapping("/screener/saved-definitions/{screenerId}/tags")
    public List<SavedScreenerTagDto> listTags(@PathVariable UUID screenerId, @RequestParam String userId) { return service.listScreenerTags(screenerId, userId); }
    @PutMapping("/screener/saved-definitions/{screenerId}/tags")
    public List<SavedScreenerTagDto> replaceTags(@PathVariable UUID screenerId, @RequestParam String userId, @RequestBody List<String> tags) { return service.replaceScreenerTags(screenerId, userId, tags); }
    @GetMapping("/screener/saved-definitions/{screenerId}/shares")
    public List<SavedScreenerShareDto> listShares(@PathVariable UUID screenerId, @RequestParam String ownerUserId) { return service.listScreenerShares(screenerId, ownerUserId); }
    @PostMapping("/screener/saved-definitions/{screenerId}/shares")
    public SavedScreenerShareDto saveShare(@PathVariable UUID screenerId, @RequestBody SaveScreenerShareRequestDto request) { return service.saveScreenerShare(new SaveScreenerShareRequestDto(screenerId, request.ownerUserId(), request.sharedWithUserId(), request.permission())); }
    @PutMapping("/screener/saved-definitions/{screenerId}/shares")
    public SavedScreenerShareDto updateSharePermission(@PathVariable UUID screenerId, @RequestBody SaveScreenerShareRequestDto request) { return service.updateScreenerSharePermission(new SaveScreenerShareRequestDto(screenerId, request.ownerUserId(), request.sharedWithUserId(), request.permission())); }
    @DeleteMapping("/screener/saved-definitions/{screenerId}/shares")
    public Map<String, Object> deleteShare(@PathVariable UUID screenerId, @RequestParam String ownerUserId, @RequestParam String sharedWithUserId) { service.deleteScreenerShare(screenerId, ownerUserId, sharedWithUserId); return Map.of("deleted", true); }

    @PostMapping("/screener/bulk-actions")
    public ScreenerBulkActionResponseDto bulkAction(@RequestBody ScreenerBulkActionRequestDto request) { return service.applyBulkAction(request); }

    @GetMapping("/workspace/layout-presets")
    public List<WorkspaceLayoutPresetDto> listLayoutPresets(@RequestParam @NotBlank String userId) { return service.listLayoutPresets(userId); }
    @GetMapping("/workspace/shared-layout-presets")
    public List<WorkspaceLayoutPresetDto> listSharedLayoutPresets(@RequestParam @NotBlank String userId) { return service.listSharedLayoutPresets(userId); }
    @PostMapping("/workspace/layout-presets")
    public WorkspaceLayoutPresetDto saveLayoutPreset(@RequestBody SaveWorkspaceLayoutPresetRequestDto request) { return service.saveLayoutPreset(request); }
    @PutMapping("/workspace/layout-presets/{presetId}")
    public WorkspaceLayoutPresetDto updateLayoutPreset(@PathVariable UUID presetId, @RequestBody UpdateWorkspaceLayoutPresetRequestDto request) {
        return service.updateLayoutPreset(new UpdateWorkspaceLayoutPresetRequestDto(presetId, request.userId(), request.name(), request.exchangeCode(), request.layoutJson(), request.isDefault(), request.isFavorite()));
    }
    @PostMapping("/workspace/layout-presets/{presetId}/default")
    public WorkspaceLayoutPresetDto markDefaultLayoutPreset(@PathVariable UUID presetId, @RequestParam String userId) { return service.markDefaultLayoutPreset(presetId, userId); }
    @PostMapping("/workspace/layout-presets/{presetId}/favorite")
    public WorkspaceLayoutPresetDto markFavoriteLayoutPreset(@PathVariable UUID presetId, @RequestParam String userId, @RequestParam boolean favorite) { return service.markFavoriteLayoutPreset(presetId, userId, favorite); }
    @DeleteMapping("/workspace/layout-presets/{presetId}")
    public Map<String, Object> deleteLayoutPreset(@PathVariable UUID presetId, @RequestParam String userId) { service.deleteLayoutPreset(presetId, userId); return Map.of("deleted", true, "presetId", presetId); }
    @GetMapping("/workspace/layout-presets/{presetId}/shares")
    public List<WorkspaceLayoutPresetShareDto> listLayoutPresetShares(@PathVariable UUID presetId, @RequestParam String ownerUserId) { return service.listLayoutPresetShares(presetId, ownerUserId); }
    @PostMapping("/workspace/layout-presets/{presetId}/shares")
    public WorkspaceLayoutPresetShareDto saveLayoutPresetShare(@PathVariable UUID presetId, @RequestBody SaveWorkspaceLayoutPresetShareRequestDto request) { return service.saveLayoutPresetShare(new SaveWorkspaceLayoutPresetShareRequestDto(presetId, request.ownerUserId(), request.sharedWithUserId(), request.permission())); }
    @PutMapping("/workspace/layout-presets/{presetId}/shares")
    public WorkspaceLayoutPresetShareDto updateLayoutPresetShare(@PathVariable UUID presetId, @RequestBody SaveWorkspaceLayoutPresetShareRequestDto request) { return service.updateLayoutPresetSharePermission(new SaveWorkspaceLayoutPresetShareRequestDto(presetId, request.ownerUserId(), request.sharedWithUserId(), request.permission())); }
    @DeleteMapping("/workspace/layout-presets/{presetId}/shares")
    public Map<String, Object> deleteLayoutPresetShare(@PathVariable UUID presetId, @RequestParam String ownerUserId, @RequestParam String sharedWithUserId) { service.deleteLayoutPresetShare(presetId, ownerUserId, sharedWithUserId); return Map.of("deleted", true); }
}
