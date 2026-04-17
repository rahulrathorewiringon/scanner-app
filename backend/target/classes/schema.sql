-- Create schemas
CREATE SCHEMA IF NOT EXISTS nse_exchange_symbol;
CREATE SCHEMA IF NOT EXISTS market_nse;
CREATE SCHEMA IF NOT EXISTS core_app_nse;
CREATE SCHEMA IF NOT EXISTS app_ui;

-- Create types
CREATE TYPE public.timeframe_enum AS ENUM ('minute', 'hour', 'day', 'week', 'month');
CREATE TYPE public.bar_status_enum AS ENUM ('LIVE_PARTIAL', 'SESSION_FINAL', 'FINAL', 'EOD_RECONCILED');
CREATE TYPE public.angle_label_enum AS ENUM ('STEEP_UP', 'UP', 'FLAT', 'DOWN', 'STEEP_DOWN', 'UNKNOWN');
CREATE TYPE public.acceleration_state_enum AS ENUM ('ACCELERATING', 'DECELERATING', 'STABLE', 'UNKNOWN');

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

CREATE TABLE nse_exchange_symbol.instrument_chart_bootstrap (
    instrument_id BIGINT PRIMARY KEY,
    chart_data_exists BOOLEAN DEFAULT false,
    bootstrap_status VARCHAR(20) DEFAULT 'PENDING',
    chart_data_status VARCHAR(20) DEFAULT 'PENDING',
    chart_from_date DATE,
    chart_to_date DATE,
    chart_timeframes_available_json JSON,
    reconcile_watermark_date DATE,
    bootstrap_completed_through_date DATE,
    last_bootstrap_completed_at TIMESTAMP,
    last_reconcile_completed_at TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Market NSE Tables
CREATE TABLE market_nse.market_candle (
    instrument_id BIGINT NOT NULL,
    timeframe timeframe_enum NOT NULL,
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
    bar_status bar_status_enum DEFAULT 'FINAL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (instrument_id, timeframe, bar_start_ts)
);

CREATE TABLE market_nse.market_candle_feature_fast (
    instrument_id BIGINT NOT NULL,
    timeframe timeframe_enum NOT NULL,
    bar_start_ts TIMESTAMP NOT NULL,
    sma_5 DECIMAL(18,6),
    sma_10 DECIMAL(18,6),
    sma_20 DECIMAL(18,6),
    sma_50 DECIMAL(18,6),
    sma_100 DECIMAL(18,6),
    sma_200 DECIMAL(18,6),
    atr_5 DECIMAL(18,6),
    range_to_atr DECIMAL(10,4),
    body_pct DECIMAL(10,4),
    upper_wick_pct DECIMAL(10,4),
    lower_wick_pct DECIMAL(10,4),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (instrument_id, timeframe, bar_start_ts)
);

CREATE TABLE market_nse.market_candle_pivot (
    instrument_id BIGINT NOT NULL,
    timeframe timeframe_enum NOT NULL,
    bar_start_ts TIMESTAMP NOT NULL,
    pivot_type VARCHAR(10),
    pivot_left_arm_length INTEGER,
    pivot_right_arm_length INTEGER,
    pivot_left_arm_strength INTEGER,
    pivot_right_arm_strength INTEGER,
    trend_pivot_type VARCHAR(10),
    trend_left_arm_length INTEGER,
    trend_right_arm_length INTEGER,
    trend_left_arm_strength INTEGER,
    trend_right_arm_strength INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (instrument_id, timeframe, bar_start_ts)
);

-- App UI Tables
CREATE TABLE app_ui.saved_screener_definition (
    screener_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    trade_date DATE NOT NULL,
    default_timeframe TEXT NOT NULL,
    filter_tree JSONB NOT NULL,
    sort_spec JSONB NOT NULL,
    page_size INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.watchlist_definition (
    watchlist_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    watchlist_type TEXT NOT NULL DEFAULT 'MANUAL',
    rule_engine_type TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.watchlist_item (
    watchlist_item_id UUID PRIMARY KEY,
    watchlist_id UUID NOT NULL REFERENCES app_ui.watchlist_definition(watchlist_id) ON DELETE CASCADE,
    instrument_id BIGINT NOT NULL,
    source_action_id UUID,
    source_rule_id UUID,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.alert_rule (
    alert_rule_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    instrument_id BIGINT NOT NULL,
    rule_name TEXT NOT NULL,
    rule_type TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'ACTIVE',
    source_action_id UUID,
    source_watchlist_id UUID,
    config_json JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_ui.workspace_layout_preset (
    preset_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    layout_json JSONB NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT false,
    is_favorite BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_saved_screener_user_id ON app_ui.saved_screener_definition (user_id, updated_at DESC);
CREATE INDEX idx_watchlist_user_id ON app_ui.watchlist_definition (user_id, updated_at DESC);
CREATE INDEX idx_alert_rule_user_id ON app_ui.alert_rule (user_id, updated_at DESC);
CREATE INDEX idx_workspace_layout_user_id ON app_ui.workspace_layout_preset (user_id, updated_at DESC);