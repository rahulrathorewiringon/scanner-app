CREATE SCHEMA IF NOT EXISTS app_ui;

CREATE TABLE IF NOT EXISTS app_ui.saved_screener_definition (
    screener_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    trade_date DATE NOT NULL,
    default_timeframe TEXT NOT NULL,
    filter_tree JSONB NOT NULL,
    sort_spec JSONB NOT NULL,
    page_size INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_saved_screener_user_id
    ON app_ui.saved_screener_definition (user_id, updated_at DESC);

CREATE TABLE IF NOT EXISTS app_ui.saved_screener_tag (
    screener_id UUID NOT NULL REFERENCES app_ui.saved_screener_definition(screener_id) ON DELETE CASCADE,
    tag TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (screener_id, tag)
);

CREATE TABLE IF NOT EXISTS app_ui.saved_screener_share (
    share_id UUID PRIMARY KEY,
    screener_id UUID NOT NULL REFERENCES app_ui.saved_screener_definition(screener_id) ON DELETE CASCADE,
    owner_user_id TEXT NOT NULL,
    shared_with_user_id TEXT NOT NULL,
    permission TEXT NOT NULL DEFAULT 'VIEW',
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (screener_id, shared_with_user_id)
);

CREATE TABLE IF NOT EXISTS app_ui.workspace_layout_preset (
    preset_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    layout_json JSONB NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT false,
    is_favorite BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_workspace_layout_user_id
    ON app_ui.workspace_layout_preset (user_id, updated_at DESC);

CREATE TABLE IF NOT EXISTS app_ui.screener_bulk_action_audit (
    action_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    action_type TEXT NOT NULL,
    instrument_ids JSONB NOT NULL,
    payload JSONB,
    accepted_count INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS app_ui.watchlist_definition (
    watchlist_id UUID PRIMARY KEY,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    watchlist_type TEXT NOT NULL DEFAULT 'MANUAL',
    rule_engine_type TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (user_id, name)
);

CREATE TABLE IF NOT EXISTS app_ui.watchlist_item (
    watchlist_item_id UUID PRIMARY KEY,
    watchlist_id UUID NOT NULL REFERENCES app_ui.watchlist_definition(watchlist_id) ON DELETE CASCADE,
    instrument_id BIGINT NOT NULL,
    source_action_id UUID,
    source_rule_id UUID,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (watchlist_id, instrument_id)
);

CREATE TABLE IF NOT EXISTS app_ui.watchlist_generation_rule (
    rule_id UUID PRIMARY KEY,
    watchlist_id UUID NOT NULL REFERENCES app_ui.watchlist_definition(watchlist_id) ON DELETE CASCADE,
    user_id TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange_code TEXT NOT NULL,
    rule_type TEXT NOT NULL DEFAULT 'JSON_SCREENER_FILTER',
    rule_definition JSONB NOT NULL,
    is_enabled BOOLEAN NOT NULL DEFAULT true,
    last_generated_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_watchlist_rule_user_id
    ON app_ui.watchlist_generation_rule (user_id, updated_at DESC);

CREATE TABLE IF NOT EXISTS app_ui.alert_rule (
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
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_alert_rule_user_id
    ON app_ui.alert_rule (user_id, updated_at DESC);


CREATE TABLE IF NOT EXISTS app_ui.workspace_layout_preset_share (
    share_id UUID PRIMARY KEY,
    preset_id UUID NOT NULL REFERENCES app_ui.workspace_layout_preset(preset_id) ON DELETE CASCADE,
    owner_user_id TEXT NOT NULL,
    shared_with_user_id TEXT NOT NULL,
    permission TEXT NOT NULL DEFAULT 'VIEW',
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (preset_id, shared_with_user_id)
);
