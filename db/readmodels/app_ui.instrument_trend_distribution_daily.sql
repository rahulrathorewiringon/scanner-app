CREATE SCHEMA IF NOT EXISTS app_ui;

DROP VIEW IF EXISTS app_ui.instrument_trend_distribution_daily;

CREATE VIEW app_ui.instrument_trend_distribution_daily AS
SELECT
    ils.exchange_code,
    ils.latest_trade_date_day AS trade_date,
    ils.trend_state_day,
    COUNT(*) AS instrument_count
FROM app_ui.instrument_latest_snapshot ils
WHERE ils.exchange_code = 'NSE'
  AND COALESCE(ils.chart_data_exists, false) = true
GROUP BY
    ils.exchange_code,
    ils.latest_trade_date_day,
    ils.trend_state_day;
