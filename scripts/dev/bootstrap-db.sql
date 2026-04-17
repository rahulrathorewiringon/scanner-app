CREATE SCHEMA IF NOT EXISTS nse_exchange_symbol;
CREATE SCHEMA IF NOT EXISTS market_nse;
CREATE SCHEMA IF NOT EXISTS core_app_nse;
CREATE SCHEMA IF NOT EXISTS app_ui;

-- Apply read models manually after the database is up:
-- psql -U rathore -d trading_analysis_db -f db/readmodels/app_ui.instrument_latest_snapshot.sql
-- psql -U rathore -d trading_analysis_db -f db/readmodels/app_ui.instrument_pivot_sequence_latest.sql
-- psql -U rathore -d trading_analysis_db -f db/readmodels/app_ui.instrument_trend_distribution_daily.sql
-- psql -U rathore -d trading_analysis_db -f db/readmodels/app_ui_user_preferences.sql
-- psql -U rathore -d trading_analysis_db -f db/readmodels/app_ui_audit_and_auth.sql
