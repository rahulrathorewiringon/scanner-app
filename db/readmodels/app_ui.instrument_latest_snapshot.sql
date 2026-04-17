CREATE SCHEMA IF NOT EXISTS app_ui;

DROP VIEW IF EXISTS app_ui.instrument_latest_snapshot;

CREATE VIEW app_ui.instrument_latest_snapshot AS
WITH instrument_universe AS (
    SELECT
        im.instrument_id,
        im.symbol,
        im.trading_symbol,
        im.instrument_type,
        im.is_active,
        im.source_entity_type,
        im.source_entity_id
    FROM nse_exchange_symbol.instrument_master im
    WHERE im.is_active = true
),
bootstrap AS (
    SELECT
        icb.instrument_id,
        icb.chart_data_exists,
        icb.bootstrap_status,
        icb.chart_data_status,
        icb.chart_from_date,
        icb.chart_to_date,
        icb.chart_timeframes_available_json,
        icb.reconcile_watermark_date,
        icb.bootstrap_completed_through_date,
        icb.last_bootstrap_completed_at,
        icb.last_reconcile_completed_at,
        icb.updated_at AS bootstrap_updated_at
    FROM nse_exchange_symbol.instrument_chart_bootstrap icb
),
latest_day_candle AS (
    SELECT DISTINCT ON (mc.instrument_id) mc.instrument_id, mc.trade_date AS latest_trade_date_day, mc.close AS latest_close_day
    FROM market_nse.market_candle mc WHERE mc.timeframe = 'day'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_hour_candle AS (
    SELECT DISTINCT ON (mc.instrument_id) mc.instrument_id, mc.trade_date AS latest_trade_date_hour, mc.close AS latest_close_hour
    FROM market_nse.market_candle mc WHERE mc.timeframe = 'hour'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_week_candle AS (
    SELECT DISTINCT ON (mc.instrument_id) mc.instrument_id, mc.trade_date AS latest_trade_date_week, mc.close AS latest_close_week
    FROM market_nse.market_candle mc WHERE mc.timeframe = 'week'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_day_fast AS (
    SELECT DISTINCT ON (ff.instrument_id) ff.instrument_id, ff.sma_5, ff.sma_10, ff.sma_20, ff.body_pct
    FROM market_nse.market_candle_feature_fast ff WHERE ff.timeframe = 'day'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
latest_hour_fast AS (
    SELECT DISTINCT ON (ff.instrument_id) ff.instrument_id, ff.sma_5, ff.sma_10, ff.sma_20, ff.body_pct
    FROM market_nse.market_candle_feature_fast ff WHERE ff.timeframe = 'hour'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
latest_week_fast AS (
    SELECT DISTINCT ON (ff.instrument_id) ff.instrument_id, ff.sma_5, ff.sma_10, ff.sma_20, ff.body_pct
    FROM market_nse.market_candle_feature_fast ff WHERE ff.timeframe = 'week'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
ranked_pivots AS (
    SELECT
        pm.instrument_id,
        pm.timeframe,
        pm.pivot,
        pm.timestamp,
        pm.pivot_sequence,
        ROW_NUMBER() OVER (PARTITION BY pm.instrument_id, pm.timeframe ORDER BY pm.timestamp DESC, pm.pivot_sequence DESC) AS rn
    FROM core_app_nse.pivot_metrics pm
),
ranked_trend_pivots AS (
    SELECT
        tpm.instrument_id,
        tpm.timeframe,
        tpm.trend_pivot,
        tpm.timestamp,
        tpm.pivot_sequence,
        ROW_NUMBER() OVER (PARTITION BY tpm.instrument_id, tpm.timeframe ORDER BY tpm.timestamp DESC, tpm.pivot_sequence DESC) AS rn
    FROM core_app_nse.trend_pivot_metrics tpm
),
pivot_day AS (
    SELECT instrument_id,
      MAX(CASE WHEN rn = 1 THEN pivot END) AS latest_pivot_type_day,
      MAX(CASE WHEN rn = 2 THEN pivot END) AS previous_pivot_type_day
    FROM ranked_pivots WHERE timeframe = 'day'
    GROUP BY instrument_id
),
pivot_hour AS (
    SELECT instrument_id,
      MAX(CASE WHEN rn = 1 THEN pivot END) AS latest_pivot_type_hour,
      MAX(CASE WHEN rn = 2 THEN pivot END) AS previous_pivot_type_hour
    FROM ranked_pivots WHERE timeframe = 'hour'
    GROUP BY instrument_id
),
pivot_week AS (
    SELECT instrument_id,
      MAX(CASE WHEN rn = 1 THEN pivot END) AS latest_pivot_type_week,
      MAX(CASE WHEN rn = 2 THEN pivot END) AS previous_pivot_type_week
    FROM ranked_pivots WHERE timeframe = 'week'
    GROUP BY instrument_id
),
trend_pivot_day AS (
    SELECT instrument_id, MAX(CASE WHEN rn = 1 THEN trend_pivot END) AS latest_trend_pivot_type_day
    FROM ranked_trend_pivots WHERE timeframe = 'day'
    GROUP BY instrument_id
),
trend_pivot_hour AS (
    SELECT instrument_id, MAX(CASE WHEN rn = 1 THEN trend_pivot END) AS latest_trend_pivot_type_hour
    FROM ranked_trend_pivots WHERE timeframe = 'hour'
    GROUP BY instrument_id
),
trend_pivot_week AS (
    SELECT instrument_id, MAX(CASE WHEN rn = 1 THEN trend_pivot END) AS latest_trend_pivot_type_week
    FROM ranked_trend_pivots WHERE timeframe = 'week'
    GROUP BY instrument_id
)
SELECT
    iu.instrument_id,
    iu.symbol,
    iu.trading_symbol,
    iu.instrument_type,
    'NSE'::text AS exchange_code,
    b.chart_data_exists,
    b.bootstrap_status,
    b.chart_data_status,
    b.chart_from_date,
    b.chart_to_date,
    b.chart_timeframes_available_json,
    b.reconcile_watermark_date,
    b.bootstrap_completed_through_date,
    b.last_bootstrap_completed_at,
    b.last_reconcile_completed_at,
    ldc.latest_trade_date_day,
    lhc.latest_trade_date_hour,
    lwc.latest_trade_date_week,
    ldc.latest_close_day,
    lhc.latest_close_hour,
    lwc.latest_close_week,
    CASE WHEN ldf.sma_5 > ldf.sma_10 AND ldf.sma_10 > ldf.sma_20 THEN 'BULL_STACK_5_10_20'
         WHEN ldf.sma_5 < ldf.sma_10 AND ldf.sma_10 < ldf.sma_20 THEN 'BEAR_STACK_5_10_20'
         ELSE 'MIXED_5_10_20' END AS sma_structure_day,
    CASE WHEN lhf.sma_5 > lhf.sma_10 AND lhf.sma_10 > lhf.sma_20 THEN 'BULL_STACK_5_10_20'
         WHEN lhf.sma_5 < lhf.sma_10 AND lhf.sma_10 < lhf.sma_20 THEN 'BEAR_STACK_5_10_20'
         ELSE 'MIXED_5_10_20' END AS sma_structure_hour,
    CASE WHEN lwf.sma_5 > lwf.sma_10 AND lwf.sma_10 > lwf.sma_20 THEN 'BULL_STACK_5_10_20'
         WHEN lwf.sma_5 < lwf.sma_10 AND lwf.sma_10 < lwf.sma_20 THEN 'BEAR_STACK_5_10_20'
         ELSE 'MIXED_5_10_20' END AS sma_structure_week,
    pd.latest_pivot_type_day,
    pd.previous_pivot_type_day,
    ph.latest_pivot_type_hour,
    ph.previous_pivot_type_hour,
    pw.latest_pivot_type_week,
    pw.previous_pivot_type_week,
    tpd.latest_trend_pivot_type_day,
    tph.latest_trend_pivot_type_hour,
    tpw.latest_trend_pivot_type_week,
    CASE
      WHEN tpd.latest_trend_pivot_type_day IN ('HH','HL') AND ldf.sma_5 > ldf.sma_10 AND ldf.sma_10 > ldf.sma_20 THEN 'UPTREND'
      WHEN tpd.latest_trend_pivot_type_day IN ('LH','LL') AND ldf.sma_5 < ldf.sma_10 AND ldf.sma_10 < ldf.sma_20 THEN 'DOWNTREND'
      ELSE 'SIDEWAYS'
    END AS trend_state_day,
    CASE WHEN ldf.body_pct >= 60 THEN 'STRONG_BODY' ELSE 'NEUTRAL' END AS current_candle_pattern_day,
    CASE WHEN lhf.body_pct >= 60 THEN 'STRONG_BODY' ELSE 'NEUTRAL' END AS current_candle_pattern_hour,
    CASE WHEN lwf.body_pct >= 60 THEN 'STRONG_BODY' ELSE 'NEUTRAL' END AS current_candle_pattern_week,
    COALESCE(b.bootstrap_updated_at, now()) AS updated_at
FROM instrument_universe iu
LEFT JOIN bootstrap b ON b.instrument_id = iu.instrument_id
LEFT JOIN latest_day_candle ldc ON ldc.instrument_id = iu.instrument_id
LEFT JOIN latest_hour_candle lhc ON lhc.instrument_id = iu.instrument_id
LEFT JOIN latest_week_candle lwc ON lwc.instrument_id = iu.instrument_id
LEFT JOIN latest_day_fast ldf ON ldf.instrument_id = iu.instrument_id
LEFT JOIN latest_hour_fast lhf ON lhf.instrument_id = iu.instrument_id
LEFT JOIN latest_week_fast lwf ON lwf.instrument_id = iu.instrument_id
LEFT JOIN pivot_day pd ON pd.instrument_id = iu.instrument_id
LEFT JOIN pivot_hour ph ON ph.instrument_id = iu.instrument_id
LEFT JOIN pivot_week pw ON pw.instrument_id = iu.instrument_id
LEFT JOIN trend_pivot_day tpd ON tpd.instrument_id = iu.instrument_id
LEFT JOIN trend_pivot_hour tph ON tph.instrument_id = iu.instrument_id
LEFT JOIN trend_pivot_week tpw ON tpw.instrument_id = iu.instrument_id;
