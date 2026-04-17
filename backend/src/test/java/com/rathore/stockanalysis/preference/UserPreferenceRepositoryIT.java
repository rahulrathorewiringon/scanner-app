package com.rathore.stockanalysis.preference;

import com.rathore.stockanalysis.preference.dto.*;
import com.rathore.stockanalysis.preference.repository.UserPreferenceRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class UserPreferenceRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired UserPreferenceRepository repository;

    @Test
    void shouldSaveAndUpdateSavedScreener() {
        var saved = repository.saveScreener(new SaveScreenerRequestDto("demo-user", "Momentum", "NSE", "2026-04-17", "day", Map.of("type", "group"), List.of(Map.of("field", "symbol")), 25));
        assertNotNull(saved.screenerId());
        var updated = repository.updateScreener(new UpdateScreenerRequestDto(saved.screenerId(), "demo-user", "Momentum Updated", "NSE", "2026-04-17", "week", Map.of("type", "group"), List.of(Map.of("field", "latestClose")), 50));
        assertEquals("Momentum Updated", updated.name());
        assertEquals("week", updated.defaultTimeframe());
    }

    @Test
    void shouldSavePresetAndSetDefaultFavorite() {
        var preset = repository.saveLayoutPreset(new SaveWorkspaceLayoutPresetRequestDto("demo-user", "Desk 1", "NSE", Map.of("layout", "A"), false, false));
        repository.markFavoriteLayoutPreset(preset.presetId(), "demo-user", true);
        repository.markDefaultLayoutPreset(preset.presetId(), "demo-user");
        var listed = repository.listLayoutPresets("demo-user");
        assertEquals(1, listed.size());
        assertTrue(listed.get(0).isFavorite());
        assertTrue(listed.get(0).isDefault());
    }

    @Test
    void shouldCreateWatchlistAndAlertRulesFromBulkActions() {
        var watchlistResponse = repository.applyBulkAction(new ScreenerBulkActionRequestDto("demo-user", "ADD_TO_WATCHLIST", List.of(1L, 2L), Map.of("exchangeCode", "NSE", "watchlistName", "Swing")));
        assertEquals("WATCHLIST", watchlistResponse.domainEntityType());
        Integer watchlistItems = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM app_ui.watchlist_item", Integer.class);
        assertEquals(2, watchlistItems);

        var alertResponse = repository.applyBulkAction(new ScreenerBulkActionRequestDto("demo-user", "CREATE_ALERT", List.of(1L, 2L), Map.of("exchangeCode", "NSE", "ruleName", "Breakout Rule", "ruleType", "PRICE_ACTION")));
        assertEquals("ALERT_RULE", alertResponse.domainEntityType());
        Integer alertRules = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM app_ui.alert_rule", Integer.class);
        assertEquals(2, alertRules);
    }
}
