-- H2-compatible schema for testing
-- Create schemas
CREATE SCHEMA IF NOT EXISTS nse_exchange_symbol;
CREATE SCHEMA IF NOT EXISTS market_nse;
CREATE SCHEMA IF NOT EXISTS core_app_nse;
CREATE SCHEMA IF NOT EXISTS app_ui;

-- NSE Exchange Symbol Tables
CREATE TABLE nse_exchange_symbol.instrument_master (
    instrument_id BIGINT PRIMARY KEY,
    exchange_code VARCHAR(10) NOT NULL,
    symbol VARCHAR(50) NOT NULL,
    trading_symbol VARCHAR(50) NOT NULL,
    instrument_type VARCHAR(20) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    source_entity_type VARCHAR(20),
    source_entity_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE nse_exchange_symbol.instrument_master_equity (
    instrument_id BIGINT PRIMARY KEY,
    sector VARCHAR(100),
    industry VARCHAR(100)
);

CREATE TABLE nse_exchange_symbol.instrument_chart_bootstrap (
    instrument_id BIGINT PRIMARY KEY,
    chart_data_exists BOOLEAN DEFAULT false,
    bootstrap_status VARCHAR(20) DEFAULT 'PENDING',
    chart_data_status VARCHAR(20) DEFAULT 'PENDING',
    chart_from_date DATE,
    chart_to_date DATE,
    chart_timeframes_available_json VARCHAR(1000),
    reconcile_watermark_date DATE,
    bootstrap_completed_through_date DATE,
    last_bootstrap_completed_at TIMESTAMP,
    last_reconcile_completed_at TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Market NSE Tables
CREATE TABLE market_nse.market_candle (
    instrument_id BIGINT NOT NULL,
    timeframe VARCHAR(20) NOT NULL,
    tf_id BIGINT NOT NULL,
    bar_start_ts TIMESTAMP NOT NULL,
    bar_end_ts TIMESTAMP,
    trade_date DATE NOT NULL,
    candle_week DATE,
    open_price DECIMAL(18,6) NOT NULL,
    high_price DECIMAL(18,6) NOT NULL,
    low_price DECIMAL(18,6) NOT NULL,
    close_price DECIMAL(18,6) NOT NULL,
    volume BIGINT,
    bar_status VARCHAR(20) DEFAULT 'FINAL',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE market_nse.market_candle_feature_fast (
    instrument_id BIGINT NOT NULL,
    timeframe VARCHAR(20) NOT NULL,
    tf_id BIGINT NOT NULL,
    bar_start_ts TIMESTAMP NOT NULL,
    sma_5 DECIMAL(18,6),
    sma_10 DECIMAL(18,6),
    sma_20 DECIMAL(18,6),
    sma_50 DECIMAL(18,6),
    sma_100 DECIMAL(18,6),
    sma_200 DECIMAL(18,6),
    atr_5 DECIMAL(18,6),
    atr_14 DECIMAL(18,6),
    atr_20 DECIMAL(18,6),
    range_to_atr DECIMAL(10,4),
    body_pct DECIMAL(10,4),
    upper_wick_pct DECIMAL(10,4),
    lower_wick_pct DECIMAL(10,4)
);

CREATE TABLE market_nse.market_candle_pivot (
    instrument_id BIGINT NOT NULL,
    timeframe VARCHAR(20) NOT NULL,
    tf_id BIGINT NOT NULL,
    bar_start_ts TIMESTAMP NOT NULL,
    pivot_type VARCHAR(10) NOT NULL,
    pivot_confirmed BOOLEAN DEFAULT false,
    pivot_price DECIMAL(18,6) NOT NULL,
    trend_pivot_type VARCHAR(10)
);

-- Core App NSE Tables
CREATE TABLE core_app_nse.pivot_metrics (
    instrument_id BIGINT NOT NULL,
    symbol VARCHAR(50) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    timeframe VARCHAR(20) NOT NULL,
    tf_id BIGINT NOT NULL,
    pivot VARCHAR(10) NOT NULL,
    pivot_price DECIMAL(18,6) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    pivot_sequence BIGINT NOT NULL
);

CREATE TABLE core_app_nse.trend_pivot_metrics (
    instrument_id BIGINT NOT NULL,
    symbol VARCHAR(50) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    timeframe VARCHAR(20) NOT NULL,
    tf_id BIGINT NOT NULL,
    trend_pivot VARCHAR(10) NOT NULL,
    pivot_price DECIMAL(18,6) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    pivot_sequence BIGINT NOT NULL
);

-- App UI Tables
CREATE TABLE app_ui.saved_screener_definition (
    screener_id UUID PRIMARY KEY,
    user_id VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    trade_date DATE NOT NULL,
    default_timeframe VARCHAR(20) NOT NULL,
    filter_tree TEXT NOT NULL,
    sort_spec TEXT NOT NULL,
    page_size INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.saved_screener_tag (
    screener_id UUID NOT NULL,
    tag VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (screener_id, tag)
);

CREATE TABLE app_ui.saved_screener_share (
    share_id UUID PRIMARY KEY,
    screener_id UUID NOT NULL,
    owner_user_id VARCHAR(100) NOT NULL,
    shared_with_user_id VARCHAR(100) NOT NULL,
    permission VARCHAR(20) NOT NULL DEFAULT 'VIEW',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (screener_id, shared_with_user_id)
);

CREATE TABLE app_ui.workspace_layout_preset (
    preset_id UUID PRIMARY KEY,
    user_id VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    layout_json TEXT NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT false,
    is_favorite BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.screener_bulk_action_audit (
    action_id UUID PRIMARY KEY,
    user_id VARCHAR(100) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    instrument_ids TEXT NOT NULL,
    payload TEXT,
    accepted_count INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.watchlist_definition (
    watchlist_id UUID PRIMARY KEY,
    user_id VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    watchlist_type VARCHAR(20) NOT NULL DEFAULT 'MANUAL',
    rule_engine_type VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, name)
);

CREATE TABLE app_ui.watchlist_item (
    watchlist_item_id UUID PRIMARY KEY,
    watchlist_id UUID NOT NULL,
    instrument_id BIGINT NOT NULL,
    source_action_id UUID,
    source_rule_id UUID,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (watchlist_id, instrument_id)
);

CREATE TABLE app_ui.watchlist_generation_rule (
    rule_id UUID PRIMARY KEY,
    watchlist_id UUID NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    rule_type VARCHAR(50) NOT NULL DEFAULT 'JSON_SCREENER_FILTER',
    rule_definition TEXT NOT NULL,
    is_enabled BOOLEAN NOT NULL DEFAULT true,
    last_generated_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.alert_rule (
    alert_rule_id UUID PRIMARY KEY,
    user_id VARCHAR(100) NOT NULL,
    exchange_code VARCHAR(10) NOT NULL,
    instrument_id BIGINT NOT NULL,
    rule_name VARCHAR(200) NOT NULL,
    rule_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    source_action_id UUID,
    source_watchlist_id UUID,
    config_json TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.workspace_layout_preset_share (
    share_id UUID PRIMARY KEY,
    preset_id UUID NOT NULL,
    owner_user_id VARCHAR(100) NOT NULL,
    shared_with_user_id VARCHAR(100) NOT NULL,
    permission VARCHAR(20) NOT NULL DEFAULT 'VIEW',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (preset_id, shared_with_user_id)
);

-- Indexes
CREATE INDEX idx_saved_screener_user_id ON app_ui.saved_screener_definition (user_id);
CREATE INDEX idx_watchlist_user_id ON app_ui.watchlist_definition (user_id);
CREATE INDEX idx_alert_rule_user_id ON app_ui.alert_rule (user_id);
CREATE INDEX idx_workspace_layout_user_id ON app_ui.workspace_layout_preset (user_id);