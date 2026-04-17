CREATE SCHEMA IF NOT EXISTS app_ui;

DROP VIEW IF EXISTS app_ui.instrument_pivot_sequence_latest;

CREATE VIEW app_ui.instrument_pivot_sequence_latest AS
WITH ranked_pivots AS (
    SELECT
        pm.instrument_id,
        pm.symbol,
        pm.exchange_code,
        pm.timeframe,
        pm.tf_id,
        pm.timestamp AS pivot_ts,
        pm.pivot_sequence,
        pm.pivot AS pivot_type,
        pm.pivot_price,
        ROW_NUMBER() OVER (
            PARTITION BY pm.instrument_id, pm.timeframe
            ORDER BY pm.timestamp DESC, pm.pivot_sequence DESC
        ) AS rn
    FROM core_app_nse.pivot_metrics pm
),
ranked_trend_pivots AS (
    SELECT
        tpm.instrument_id,
        tpm.timeframe,
        tpm.tf_id,
        tpm.timestamp AS trend_pivot_ts,
        tpm.pivot_sequence AS trend_pivot_sequence,
        tpm.trend_pivot AS trend_pivot_type,
        tpm.pivot_price AS trend_pivot_price,
        ROW_NUMBER() OVER (
            PARTITION BY tpm.instrument_id, tpm.timeframe
            ORDER BY tpm.timestamp DESC, tpm.pivot_sequence DESC
        ) AS rn
    FROM core_app_nse.trend_pivot_metrics tpm
)
SELECT
    rp.instrument_id,
    rp.symbol,
    rp.exchange_code,
    rp.timeframe,
    rp.tf_id,
    rp.pivot_ts,
    rp.pivot_sequence,
    rp.pivot_type,
    rp.pivot_price,
    rtp.trend_pivot_ts,
    rtp.trend_pivot_sequence,
    rtp.trend_pivot_type,
    rtp.trend_pivot_price,
    rp.rn
FROM ranked_pivots rp
LEFT JOIN ranked_trend_pivots rtp
    ON rtp.instrument_id = rp.instrument_id
   AND rtp.timeframe = rp.timeframe
   AND rtp.rn = rp.rn
WHERE rp.rn <= 20;
