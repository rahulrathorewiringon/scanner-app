package com.rathore.stockanalysis.watchlist.controller;

import com.rathore.stockanalysis.watchlist.dto.WatchlistDtos;
import com.rathore.stockanalysis.watchlist.service.WatchlistConsoleService;
import jakarta.validation.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@Validated
public class WatchlistConsoleController {
    private final WatchlistConsoleService service;

    public WatchlistConsoleController(WatchlistConsoleService service) {
        this.service = service;
    }

    @GetMapping("/watchlists")
    public List<WatchlistDtos.WatchlistDefinitionDto> listWatchlists(@RequestParam @NotBlank String userId) { return service.listWatchlists(userId); }
    @PostMapping("/watchlists")
    public WatchlistDtos.WatchlistDefinitionDto createWatchlist(@RequestBody WatchlistDtos.CreateWatchlistRequestDto request) { return service.createWatchlist(request); }
    @GetMapping("/watchlists/{watchlistId}")
    public WatchlistDtos.WatchlistDetailDto getWatchlistDetail(@PathVariable UUID watchlistId, @RequestParam @NotBlank String userId) { return service.getWatchlistDetail(userId, watchlistId); }
    @PutMapping("/watchlists/{watchlistId}")
    public WatchlistDtos.WatchlistDefinitionDto updateWatchlist(@PathVariable UUID watchlistId, @RequestBody WatchlistDtos.UpdateWatchlistRequestDto request) { return service.updateWatchlist(new WatchlistDtos.UpdateWatchlistRequestDto(watchlistId, request.userId(), request.name(), request.exchangeCode(), request.watchlistType(), request.ruleEngineType())); }
    @DeleteMapping("/watchlists/{watchlistId}")
    public Map<String,Object> deleteWatchlist(@PathVariable UUID watchlistId, @RequestParam @NotBlank String userId) { service.deleteWatchlist(watchlistId, userId); return Map.of("deleted", true); }
    @GetMapping("/watchlists/{watchlistId}/items")
    public List<WatchlistDtos.WatchlistItemDto> listWatchlistItems(@PathVariable UUID watchlistId, @RequestParam @NotBlank String userId) { return service.listWatchlistItems(userId, watchlistId); }
    @PostMapping("/watchlists/{watchlistId}/items")
    public WatchlistDtos.WatchlistItemDto addWatchlistItem(@PathVariable UUID watchlistId, @RequestBody WatchlistDtos.CreateWatchlistItemRequestDto request) { return service.addWatchlistItem(watchlistId, request); }
    @PutMapping("/watchlists/{watchlistId}/items/{watchlistItemId}")
    public WatchlistDtos.WatchlistItemDto updateWatchlistItem(@PathVariable UUID watchlistId, @PathVariable UUID watchlistItemId, @RequestBody WatchlistDtos.UpdateWatchlistItemRequestDto request) { return service.updateWatchlistItem(watchlistId, new WatchlistDtos.UpdateWatchlistItemRequestDto(watchlistItemId, request.userId(), request.note())); }
    @DeleteMapping("/watchlists/{watchlistId}/items/{watchlistItemId}")
    public Map<String,Object> deleteWatchlistItem(@PathVariable UUID watchlistId, @PathVariable UUID watchlistItemId, @RequestParam @NotBlank String userId) { service.deleteWatchlistItem(watchlistId, watchlistItemId, userId); return Map.of("deleted", true); }

    @GetMapping("/watchlists/rules")
    public List<WatchlistDtos.WatchlistGenerationRuleDto> listRules(@RequestParam @NotBlank String userId) { return service.listRules(userId); }
    @PostMapping("/watchlists/rules")
    public WatchlistDtos.WatchlistGenerationRuleDto saveRule(@RequestBody WatchlistDtos.SaveWatchlistGenerationRuleRequestDto request) { return service.saveRule(request); }
    @PutMapping("/watchlists/rules/{ruleId}")
    public WatchlistDtos.WatchlistGenerationRuleDto updateRule(@PathVariable UUID ruleId, @RequestBody WatchlistDtos.UpdateWatchlistGenerationRuleRequestDto request) {
        return service.updateRule(new WatchlistDtos.UpdateWatchlistGenerationRuleRequestDto(ruleId, request.userId(), request.watchlistId(), request.name(), request.exchangeCode(), request.ruleType(), request.ruleDefinition(), request.isEnabled()));
    }
    @DeleteMapping("/watchlists/rules/{ruleId}")
    public Map<String, Object> deleteRule(@PathVariable UUID ruleId, @RequestParam @NotBlank String userId) { service.deleteRule(ruleId, userId); return Map.of("deleted", true, "ruleId", ruleId); }
    @PostMapping("/watchlists/rules/{ruleId}/generate")
    public WatchlistDtos.GenerateWatchlistFromRuleResponseDto generateRule(@PathVariable UUID ruleId, @RequestParam @NotBlank String userId) { return service.generateRule(ruleId, userId); }

    @GetMapping("/alerts/rules")
    public List<WatchlistDtos.AlertRuleDto> listAlerts(@RequestParam @NotBlank String userId) { return service.listAlertRules(userId); }
    @GetMapping("/alerts/rules/{alertRuleId}")
    public WatchlistDtos.AlertRuleDto getAlertDetail(@PathVariable UUID alertRuleId, @RequestParam @NotBlank String userId) { return service.getAlertRuleDetail(userId, alertRuleId); }
    @PutMapping("/alerts/rules/{alertRuleId}")
    public WatchlistDtos.AlertRuleDto updateAlert(@PathVariable UUID alertRuleId, @RequestBody WatchlistDtos.UpdateAlertRuleRequestDto request) { return service.updateAlertRule(new WatchlistDtos.UpdateAlertRuleRequestDto(alertRuleId, request.userId(), request.ruleName(), request.ruleType(), request.status(), request.configJson())); }
    @DeleteMapping("/alerts/rules/{alertRuleId}")
    public Map<String,Object> deleteAlert(@PathVariable UUID alertRuleId, @RequestParam @NotBlank String userId) { service.deleteAlertRule(alertRuleId, userId); return Map.of("deleted", true); }
    @PutMapping("/alerts/rules/{alertRuleId}/status")
    public Map<String, Object> updateAlertStatus(@PathVariable UUID alertRuleId, @RequestParam @NotBlank String userId, @RequestParam @NotBlank String status) { service.updateAlertRuleStatus(alertRuleId, userId, status); return Map.of("updated", true, "alertRuleId", alertRuleId, "status", status); }
}
