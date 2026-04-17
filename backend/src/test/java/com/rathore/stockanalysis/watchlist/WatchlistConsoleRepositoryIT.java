package com.rathore.stockanalysis.watchlist;

import com.rathore.stockanalysis.preference.dto.SaveScreenerRequestDto;
import com.rathore.stockanalysis.preference.dto.SaveScreenerShareRequestDto;
import com.rathore.stockanalysis.preference.repository.UserPreferenceRepository;
import com.rathore.stockanalysis.support.PostgresIntegrationTestSupport;
import com.rathore.stockanalysis.watchlist.dto.WatchlistDtos;
import com.rathore.stockanalysis.watchlist.repository.WatchlistConsoleRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class WatchlistConsoleRepositoryIT extends PostgresIntegrationTestSupport {
    @Autowired WatchlistConsoleRepository repository;
    @Autowired UserPreferenceRepository userPreferenceRepository;

    @Test
    void shouldPersistTagsAndSharesForSavedScreener() {
        var screener = userPreferenceRepository.saveScreener(new SaveScreenerRequestDto(
                "demo-user", "Momentum", "NSE", "2026-04-17", "day",
                Map.of("type", "group", "id", "root", "operator", "AND", "enabled", true, "children", List.of()),
                List.of(Map.of("field", "symbol", "direction", "asc")), 25
        ));
        var tags = userPreferenceRepository.replaceScreenerTags(screener.screenerId(), "demo-user", List.of("momentum", "swing"));
        assertEquals(2, tags.size());
        var share = userPreferenceRepository.saveScreenerShare(new SaveScreenerShareRequestDto(screener.screenerId(), "demo-user", "teammate", "VIEW"));
        assertEquals("teammate", share.sharedWithUserId());
    }

    @Test
    void shouldGenerateWatchlistFromJsonRule() {
        jdbcTemplate.execute("INSERT INTO app_ui.watchlist_definition (watchlist_id, user_id, name, exchange_code, watchlist_type, rule_engine_type) VALUES ('11111111-1111-1111-1111-111111111111', 'demo-user', 'Generated Momentum', 'NSE', 'RULE_GENERATED', 'JSON_SCREENER_FILTER')");
        var rule = repository.saveWatchlistGenerationRule(new WatchlistDtos.SaveWatchlistGenerationRuleRequestDto(
                "demo-user",
                UUID.fromString("11111111-1111-1111-1111-111111111111"),
                "Daily Uptrend",
                "NSE",
                "JSON_SCREENER_FILTER",
                Map.of(
                        "tradeDate", "2026-04-17",
                        "defaultTimeframe", "day",
                        "pageSize", 100,
                        "filterTree", Map.of(
                                "type", "group",
                                "id", "root",
                                "operator", "AND",
                                "enabled", true,
                                "children", List.of(Map.of(
                                        "type", "condition",
                                        "id", "c1",
                                        "enabled", true,
                                        "fieldGroup", "signal",
                                        "field", "trendState",
                                        "timeframe", "day",
                                        "operator", "eq",
                                        "value", Map.of("kind", "single", "value", "UPTREND")
                                ))
                        )
                ),
                true
        ));
        var generated = repository.generateWatchlistFromRule(rule.ruleId(), "demo-user");
        assertTrue(generated.insertedCount() >= 1);
        var items = repository.listWatchlistItems("demo-user", generated.watchlistId());
        assertFalse(items.isEmpty());
    }
}
