CREATE SCHEMA IF NOT EXISTS app_ui;

CREATE TABLE IF NOT EXISTS app_ui.watchlist_audit_event (
    audit_event_id BIGSERIAL PRIMARY KEY,
    watchlist_id BIGINT NOT NULL,
    user_id TEXT NOT NULL,
    event_type TEXT NOT NULL,
    entity_type TEXT NOT NULL,
    entity_id TEXT,
    before_json JSONB,
    after_json JSONB,
    event_ts TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS app_ui.alert_rule_audit_event (
    audit_event_id BIGSERIAL PRIMARY KEY,
    alert_rule_id BIGINT NOT NULL,
    user_id TEXT NOT NULL,
    event_type TEXT NOT NULL,
    before_json JSONB,
    after_json JSONB,
    event_ts TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS app_ui.user_role_assignment (
    user_id TEXT NOT NULL,
    role_code TEXT NOT NULL,
    PRIMARY KEY (user_id, role_code)
);

ALTER TABLE IF EXISTS app_ui.saved_screener_share
    ADD COLUMN IF NOT EXISTS permission_code TEXT NOT NULL DEFAULT 'VIEW';

ALTER TABLE IF EXISTS app_ui.workspace_layout_preset_share
    ADD COLUMN IF NOT EXISTS permission_code TEXT NOT NULL DEFAULT 'VIEW';

CREATE INDEX IF NOT EXISTS idx_watchlist_audit_watchlist_ts
    ON app_ui.watchlist_audit_event (watchlist_id, event_ts DESC);

CREATE INDEX IF NOT EXISTS idx_alert_audit_rule_ts
    ON app_ui.alert_rule_audit_event (alert_rule_id, event_ts DESC);

CREATE INDEX IF NOT EXISTS idx_user_role_assignment_user
    ON app_ui.user_role_assignment (user_id);
