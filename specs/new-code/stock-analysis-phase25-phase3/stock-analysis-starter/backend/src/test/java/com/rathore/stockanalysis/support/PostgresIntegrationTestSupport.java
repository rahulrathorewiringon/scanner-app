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

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
            .withDatabaseName("stock_analysis_test")
            .withUsername("postgres")
            .withPassword("postgres");

    @DynamicPropertySource
    static void register(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    protected JdbcTemplate jdbcTemplate;

    @BeforeEach
    void resetDatabase() {
        exec("DROP SCHEMA IF EXISTS app_ui CASCADE");
        exec("DROP SCHEMA IF EXISTS nse_exchange_symbol CASCADE");
        exec("DROP SCHEMA IF EXISTS market_nse CASCADE");
        exec("DROP SCHEMA IF EXISTS core_app_nse CASCADE");
        createSchemas();
        createTables();
        seedData();
        createViews();
    }

    protected void exec(String sql) { jdbcTemplate.execute(sql); }

    protected void createSchemas() {
        exec("CREATE SCHEMA nse_exchange_symbol");
        exec("CREATE SCHEMA market_nse");
        exec("CREATE SCHEMA core_app_nse");
        exec("CREATE SCHEMA app_ui");
    }

    protected void createTables() {
        exec("CREATE TABLE nse_exchange_symbol.instrument_master (instrument_id BIGINT PRIMARY KEY, symbol TEXT, trading_symbol TEXT, instrument_type TEXT, is_active BOOLEAN, source_entity_type TEXT, source_entity_id BIGINT)");
        exec("CREATE TABLE nse_exchange_symbol.instrument_master_equity (instrument_id BIGINT PRIMARY KEY, sector TEXT, industry TEXT)");
        exec("CREATE TABLE nse_exchange_symbol.instrument_chart_bootstrap (instrument_id BIGINT PRIMARY KEY, chart_data_exists BOOLEAN, bootstrap_status TEXT, chart_data_status TEXT, chart_from_date DATE, chart_to_date DATE, chart_timeframes_available_json JSONB, reconcile_watermark_date DATE, bootstrap_completed_through_date DATE, last_bootstrap_completed_at TIMESTAMP, last_reconcile_completed_at TIMESTAMP, updated_at TIMESTAMP)");
        exec("CREATE TABLE market_nse.market_candle (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, bar_end_ts TIMESTAMP, trade_date DATE, open DOUBLE PRECISION, high DOUBLE PRECISION, low DOUBLE PRECISION, close DOUBLE PRECISION, volume DOUBLE PRECISION, updated_at TIMESTAMP)");
        exec("CREATE TABLE market_nse.market_candle_feature_fast (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, sma_5 DOUBLE PRECISION, sma_10 DOUBLE PRECISION, sma_20 DOUBLE PRECISION, sma_50 DOUBLE PRECISION, sma_100 DOUBLE PRECISION, sma_200 DOUBLE PRECISION, atr_5 DOUBLE PRECISION, atr_14 DOUBLE PRECISION, atr_20 DOUBLE PRECISION, range_to_atr DOUBLE PRECISION, body_pct DOUBLE PRECISION, upper_wick_pct DOUBLE PRECISION, lower_wick_pct DOUBLE PRECISION)");
        exec("CREATE TABLE market_nse.market_candle_pivot (instrument_id BIGINT, timeframe TEXT, tf_id BIGINT, bar_start_ts TIMESTAMP, pivot_type TEXT, pivot_confirmed BOOLEAN, pivot_price DOUBLE PRECISION, trend_pivot_type TEXT)");
        exec("CREATE TABLE core_app_nse.pivot_metrics (instrument_id BIGINT, symbol TEXT, exchange_code TEXT, timeframe TEXT, tf_id BIGINT, pivot TEXT, pivot_price DOUBLE PRECISION, timestamp TIMESTAMP, pivot_sequence BIGINT)");
        exec("CREATE TABLE core_app_nse.trend_pivot_metrics (instrument_id BIGINT, symbol TEXT, exchange_code TEXT, timeframe TEXT, tf_id BIGINT, trend_pivot TEXT, pivot_price DOUBLE PRECISION, timestamp TIMESTAMP, pivot_sequence BIGINT)");
    }

    protected void seedData() {
        exec("INSERT INTO nse_exchange_symbol.instrument_master VALUES (1,'RELIANCE','RELIANCE','EQUITY',true,'EQUITY',1),(2,'TCS','TCS','EQUITY',true,'EQUITY',2),(3,'NIFTY50','NIFTY50','INDEX',true,'INDEX',3)");
        exec("INSERT INTO nse_exchange_symbol.instrument_master_equity VALUES (1,'Energy','Oil & Gas'),(2,'IT','Software')");
        exec("INSERT INTO nse_exchange_symbol.instrument_chart_bootstrap VALUES "
            + "(1,true,'SUCCESS','FULL','2025-01-01','2026-04-17','["hour","day","week"]'::jsonb,'2026-04-17','2026-04-17','2026-04-17 10:00:00','2026-04-17 11:00:00','2026-04-17 11:00:00'),"
            + "(2,true,'SUCCESS','FULL','2025-01-01','2026-04-17','["day","week"]'::jsonb,'2026-04-17','2026-04-17','2026-04-17 10:00:00','2026-04-17 11:00:00','2026-04-17 11:00:00'),"
            + "(3,false,'NEW','MISSING',NULL,NULL,'[]'::jsonb,NULL,NULL,NULL,NULL,'2026-04-17 11:00:00')");
        
        for inst, close, s5, s10, s20, trendp in [(1,2950,110,100,90,'HH'),(2,4100,80,90,100,'LL')]:
            for tf in ['day','week','hour']:
                exec(f"INSERT INTO market_nse.market_candle VALUES ({inst}, '{tf}', 10, '2026-04-17 09:15:00', '2026-04-17 15:30:00', '2026-04-17', 100, 120, 95, {close}, 1000, '2026-04-17 15:31:00')")
                exec(f"INSERT INTO market_nse.market_candle_feature_fast VALUES ({inst}, '{tf}', 10, '2026-04-17 09:15:00', {s5}, {s10}, {s20}, 70, 60, 50, 1, 2, 3, 1.5, 65, 5, 30)")
                exec(f"INSERT INTO market_nse.market_candle_pivot VALUES ({inst}, '{tf}', 10, '2026-04-17 09:15:00', 'PH', true, {close}, '{trendp}')")
                exec(f"INSERT INTO core_app_nse.pivot_metrics VALUES ({inst}, '{'RELIANCE' if inst==1 else 'TCS'}', 'NSE', '{tf}', 10, 'PH', {close}, '2026-04-17 09:15:00', 10)")
                exec(f"INSERT INTO core_app_nse.trend_pivot_metrics VALUES ({inst}, '{'RELIANCE' if inst==1 else 'TCS'}', 'NSE', '{tf}', 10, '{trendp}', {close}, '2026-04-17 09:15:00', 10)")
    }

    protected void createViews() {
        try {
            String view1 = java.nio.file.Files.readString(java.nio.file.Path.of("db/readmodels/app_ui.instrument_latest_snapshot.sql"));
            String view2 = java.nio.file.Files.readString(java.nio.file.Path.of("db/readmodels/app_ui.instrument_pivot_sequence_latest.sql"));
            String view3 = java.nio.file.Files.readString(java.nio.file.Path.of("db/readmodels/app_ui.instrument_trend_distribution_daily.sql"));
            exec(view1);
            exec(view2);
            exec(view3);
        } catch (java.io.IOException e) {
            throw new RuntimeException(e);
        }
    }
}
