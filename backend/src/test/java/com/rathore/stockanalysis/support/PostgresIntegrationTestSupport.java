package com.rathore.stockanalysis.support;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

@Testcontainers
@SpringBootTest
@ActiveProfiles("test")
@TestInstance(Lifecycle.PER_CLASS)
public abstract class PostgresIntegrationTestSupport {
    @Container static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine").withDatabaseName("stock_analysis_test").withUsername("postgres").withPassword("postgres");
    @DynamicPropertySource static void register(DynamicPropertyRegistry registry) { registry.add("spring.datasource.url", postgres::getJdbcUrl); registry.add("spring.datasource.username", postgres::getUsername); registry.add("spring.datasource.password", postgres::getPassword); }
    @Autowired protected JdbcTemplate jdbcTemplate;
    @BeforeEach void resetDatabase() { exec("DROP SCHEMA IF EXISTS app_ui CASCADE"); exec("DROP SCHEMA IF EXISTS nse_exchange_symbol CASCADE"); exec("DROP SCHEMA IF EXISTS market_nse CASCADE"); exec("DROP SCHEMA IF EXISTS core_app_nse CASCADE"); createSchemas(); createTables(); seedData(); createViews(); }
    protected void exec(String sql) { jdbcTemplate.execute(sql); }
    protected void createSchemas() { exec("CREATE SCHEMA nse_exchange_symbol"); exec("CREATE SCHEMA market_nse"); exec("CREATE SCHEMA core_app_nse"); exec("CREATE SCHEMA app_ui"); }
    protected void createTables() {
        exec("CREATE TABLE nse_exchange_symbol.instrument_master (instrument_id BIGINT PRIMARY KEY, symbol TEXT, trading_symbol TEXT, instrument_type TEXT, is_active BOOLEAN, source_entity_type TEXT, source_entity_id BIGINT)");
        exec("CREATE TABLE nse_exchange_symbol.instrument_master_equity (instrument_id BIGINT PRIMARY KEY, sector TEXT, industry TEXT)");
        exec("CREATE TABLE nse_exchange_symbol.instrument_chart_bootstrap (instrument_id BIGINT PRIMARY KEY, chart_data_exists BOOLEAN, bootstrap_status TEXT, chart_data_status TEXT, chart_from_date DATE, chart_to_date DATE, chart_timeframes_available_json JSONB, reconcile_watermark_date DATE, bootstrap_completed_through_date DATE, last_bootstrap_completed_at TIMESTAMP, last_reconcile_completed_at TIMESTAMP, updated_at TIMESTAMP)");
        exec("CREATE TABLE market_nse.market_candle (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, bar_end_ts TIMESTAMP, trade_date DATE, open DOUBLE PRECISION, high DOUBLE PRECISION, low DOUBLE PRECISION, close DOUBLE PRECISION, volume DOUBLE PRECISION, updated_at TIMESTAMP)");
        exec("CREATE TABLE market_nse.market_candle_feature_fast (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, sma_5 DOUBLE PRECISION, sma_10 DOUBLE PRECISION, sma_20 DOUBLE PRECISION, sma_50 DOUBLE PRECISION, sma_100 DOUBLE PRECISION, sma_200 DOUBLE PRECISION, atr_5 DOUBLE PRECISION, atr_14 DOUBLE PRECISION, atr_20 DOUBLE PRECISION, range_to_atr DOUBLE PRECISION, body_pct DOUBLE PRECISION, upper_wick_pct DOUBLE PRECISION, lower_wick_pct DOUBLE PRECISION)");
        exec("CREATE TABLE market_nse.market_candle_pivot (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, pivot_type TEXT, pivot_confirmed BOOLEAN, pivot_price DOUBLE PRECISION, trend_pivot_type TEXT)");
        exec("CREATE TABLE core_app_nse.pivot_metrics (instrument_id BIGINT, symbol TEXT, exchange_code TEXT, timeframe TEXT, tf_id BIGINT, pivot TEXT, pivot_price DOUBLE PRECISION, timestamp TIMESTAMP, pivot_sequence BIGINT)");
        exec("CREATE TABLE core_app_nse.trend_pivot_metrics (instrument_id BIGINT, symbol TEXT, exchange_code TEXT, timeframe TEXT, tf_id BIGINT, trend_pivot TEXT, pivot_price DOUBLE PRECISION, timestamp TIMESTAMP, pivot_sequence BIGINT)");
        exec("CREATE TABLE app_ui.saved_screener_definition (screener_id UUID PRIMARY KEY, user_id TEXT NOT NULL, name TEXT NOT NULL, exchange_code TEXT NOT NULL, trade_date DATE NOT NULL, default_timeframe TEXT NOT NULL, filter_tree JSONB NOT NULL, sort_spec JSONB NOT NULL, page_size INTEGER NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT now(), updated_at TIMESTAMP NOT NULL DEFAULT now())");
        exec("CREATE TABLE app_ui.saved_screener_tag (screener_id UUID NOT NULL, tag TEXT NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT now(), PRIMARY KEY (screener_id, tag))");
        exec("CREATE TABLE app_ui.saved_screener_share (share_id UUID PRIMARY KEY, screener_id UUID NOT NULL, owner_user_id TEXT NOT NULL, shared_with_user_id TEXT NOT NULL, permission TEXT NOT NULL DEFAULT 'VIEW', created_at TIMESTAMP NOT NULL DEFAULT now(), UNIQUE (screener_id, shared_with_user_id))");
        exec("CREATE TABLE app_ui.workspace_layout_preset (preset_id UUID PRIMARY KEY, user_id TEXT NOT NULL, name TEXT NOT NULL, exchange_code TEXT NOT NULL, layout_json JSONB NOT NULL, is_default BOOLEAN NOT NULL DEFAULT false, is_favorite BOOLEAN NOT NULL DEFAULT false, created_at TIMESTAMP NOT NULL DEFAULT now(), updated_at TIMESTAMP NOT NULL DEFAULT now())");
        exec("CREATE TABLE app_ui.screener_bulk_action_audit (action_id UUID PRIMARY KEY, user_id TEXT NOT NULL, action_type TEXT NOT NULL, instrument_ids JSONB NOT NULL, payload JSONB, accepted_count INTEGER NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT now())");
        exec("CREATE TABLE app_ui.watchlist_definition (watchlist_id UUID PRIMARY KEY, user_id TEXT NOT NULL, name TEXT NOT NULL, exchange_code TEXT NOT NULL, watchlist_type TEXT NOT NULL DEFAULT 'MANUAL', rule_engine_type TEXT, created_at TIMESTAMP NOT NULL DEFAULT now(), updated_at TIMESTAMP NOT NULL DEFAULT now(), UNIQUE (user_id, name))");
        exec("CREATE TABLE app_ui.watchlist_item (watchlist_item_id UUID PRIMARY KEY, watchlist_id UUID NOT NULL, instrument_id BIGINT NOT NULL, source_action_id UUID, source_rule_id UUID, note TEXT, created_at TIMESTAMP NOT NULL DEFAULT now(), UNIQUE (watchlist_id, instrument_id))");
        exec("CREATE TABLE app_ui.watchlist_generation_rule (rule_id UUID PRIMARY KEY, watchlist_id UUID NOT NULL, user_id TEXT NOT NULL, name TEXT NOT NULL, exchange_code TEXT NOT NULL, rule_type TEXT NOT NULL DEFAULT 'JSON_SCREENER_FILTER', rule_definition JSONB NOT NULL, is_enabled BOOLEAN NOT NULL DEFAULT true, last_generated_at TIMESTAMP, created_at TIMESTAMP NOT NULL DEFAULT now(), updated_at TIMESTAMP NOT NULL DEFAULT now())");
        exec("CREATE TABLE app_ui.alert_rule (alert_rule_id UUID PRIMARY KEY, user_id TEXT NOT NULL, exchange_code TEXT NOT NULL, instrument_id BIGINT NOT NULL, rule_name TEXT NOT NULL, rule_type TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'ACTIVE', source_action_id UUID, source_watchlist_id UUID, config_json JSONB, created_at TIMESTAMP NOT NULL DEFAULT now(), updated_at TIMESTAMP NOT NULL DEFAULT now())");
        exec("CREATE TABLE app_ui.workspace_layout_preset_share (share_id UUID PRIMARY KEY, preset_id UUID NOT NULL, owner_user_id TEXT NOT NULL, shared_with_user_id TEXT NOT NULL, permission TEXT NOT NULL DEFAULT 'VIEW', created_at TIMESTAMP NOT NULL DEFAULT now(), UNIQUE (preset_id, shared_with_user_id))");
    }
    protected void seedData() {
        exec("INSERT INTO nse_exchange_symbol.instrument_master VALUES (1,'RELIANCE','RELIANCE','EQUITY',true,'EQUITY',1),(2,'TCS','TCS','EQUITY',true,'EQUITY',2),(3,'NIFTY50','NIFTY50','INDEX',true,'INDEX',3)");
        exec("INSERT INTO nse_exchange_symbol.instrument_master_equity VALUES (1,'Energy','Oil & Gas'),(2,'IT','Software')");
        exec("INSERT INTO nse_exchange_symbol.instrument_chart_bootstrap VALUES (1,true,'SUCCESS','FULL','2025-01-01','2026-04-17','[\"hour\",\"day\",\"week\"]'::jsonb,'2026-04-17','2026-04-17','2026-04-17 10:00:00','2026-04-17 11:00:00','2026-04-17 11:00:00'),(2,true,'SUCCESS','FULL','2025-01-01','2026-04-17','[\"day\",\"week\"]'::jsonb,'2026-04-17','2026-04-17','2026-04-17 10:00:00','2026-04-17 11:00:00','2026-04-17 11:00:00'),(3,false,'NEW','MISSING',NULL,NULL,'[]'::jsonb,NULL,NULL,NULL,NULL,'2026-04-17 11:00:00')");
        for (int inst : new int[]{1,2}) { double close = inst == 1 ? 2950 : 4100; double s5 = inst == 1 ? 110 : 80; double s10 = inst == 1 ? 100 : 90; double s20 = inst == 1 ? 90 : 100; String trendp = inst == 1 ? "HH" : "LL"; String prevpivot = inst == 1 ? "PL" : "PH"; String symbol = inst == 1 ? "RELIANCE" : "TCS"; for (String tf : new String[]{"day","week","hour"}) { exec("INSERT INTO market_nse.market_candle VALUES ("+inst+", '"+tf+"', 10, '2026-04-17 09:15:00', '2026-04-17 15:30:00', '2026-04-17', 100, 120, 95, "+close+", 1000, '2026-04-17 15:31:00')"); exec("INSERT INTO market_nse.market_candle_feature_fast VALUES ("+inst+", '"+tf+"', 10, '2026-04-17 09:15:00', "+s5+", "+s10+", "+s20+", 70, 60, 50, 1, 2, 3, 1.5, 65, 5, 30)"); exec("INSERT INTO market_nse.market_candle_pivot VALUES ("+inst+", '"+tf+"', 10, '2026-04-17 09:15:00', 'PH', true, "+close+", '"+trendp+"')"); exec("INSERT INTO core_app_nse.pivot_metrics VALUES ("+inst+", '"+symbol+"', 'NSE', '"+tf+"', 9, '"+prevpivot+"', "+(close-10)+", '2026-04-16 09:15:00', 9)"); exec("INSERT INTO core_app_nse.pivot_metrics VALUES ("+inst+", '"+symbol+"', 'NSE', '"+tf+"', 10, 'PH', "+close+", '2026-04-17 09:15:00', 10)"); exec("INSERT INTO core_app_nse.trend_pivot_metrics VALUES ("+inst+", '"+symbol+"', 'NSE', '"+tf+"', 10, '"+trendp+"', "+close+", '2026-04-17 09:15:00', 10)"); } }
    }
    protected void createViews() { try { java.nio.file.Path root = java.nio.file.Path.of(System.getProperty("user.dir")); exec(java.nio.file.Files.readString(root.resolve("../db/readmodels/app_ui.instrument_latest_snapshot.sql").normalize())); exec(java.nio.file.Files.readString(root.resolve("../db/readmodels/app_ui.instrument_pivot_sequence_latest.sql").normalize())); exec(java.nio.file.Files.readString(root.resolve("../db/readmodels/app_ui.instrument_trend_distribution_daily.sql").normalize())); } catch (java.io.IOException e) { throw new RuntimeException(e); } }
}
