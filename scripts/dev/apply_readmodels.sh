#!/usr/bin/env bash
set -euo pipefail

DB_NAME="${DB_NAME:-trading_analysis_db}"
DB_USER="${DB_USER:-rathore}"

psql -U "$DB_USER" -d "$DB_NAME" -f db/readmodels/app_ui.instrument_latest_snapshot.sql
psql -U "$DB_USER" -d "$DB_NAME" -f db/readmodels/app_ui.instrument_pivot_sequence_latest.sql
psql -U "$DB_USER" -d "$DB_NAME" -f db/readmodels/app_ui.instrument_trend_distribution_daily.sql
psql -U "$DB_USER" -d "$DB_NAME" -f db/readmodels/app_ui_user_preferences.sql
psql -U "$DB_USER" -d "$DB_NAME" -f db/readmodels/app_ui_audit_and_auth.sql
