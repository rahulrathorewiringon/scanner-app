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
    SELECT DISTINCT ON (mc.instrument_id)
        mc.instrument_id,
        mc.trade_date AS latest_trade_date_day,
        mc.bar_start_ts AS latest_bar_start_ts_day,
        mc.close AS latest_close_day
    FROM market_nse.market_candle mc
    WHERE mc.timeframe = 'day'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_hour_candle AS (
    SELECT DISTINCT ON (mc.instrument_id)
        mc.instrument_id,
        mc.trade_date AS latest_trade_date_hour,
        mc.bar_start_ts AS latest_bar_start_ts_hour,
        mc.close AS latest_close_hour
    FROM market_nse.market_candle mc
    WHERE mc.timeframe = 'hour'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_week_candle AS (
    SELECT DISTINCT ON (mc.instrument_id)
        mc.instrument_id,
        mc.trade_date AS latest_trade_date_week,
        mc.bar_start_ts AS latest_bar_start_ts_week,
        mc.close AS latest_close_week
    FROM market_nse.market_candle mc
    WHERE mc.timeframe = 'week'
    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC
),
latest_day_fast AS (
    SELECT DISTINCT ON (ff.instrument_id)
        ff.instrument_id,
        ff.sma_5,
        ff.sma_10,
        ff.sma_20,
        ff.sma_50,
        ff.body_pct,
        ff.upper_wick_pct,
        ff.lower_wick_pct,
        ff.range_to_atr
    FROM market_nse.market_candle_feature_fast ff
    WHERE ff.timeframe = 'day'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
latest_hour_fast AS (
    SELECT DISTINCT ON (ff.instrument_id)
        ff.instrument_id,
        ff.sma_5,
        ff.sma_10,
        ff.sma_20
    FROM market_nse.market_candle_feature_fast ff
    WHERE ff.timeframe = 'hour'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
latest_week_fast AS (
    SELECT DISTINCT ON (ff.instrument_id)
        ff.instrument_id,
        ff.sma_5,
        ff.sma_10,
        ff.sma_20
    FROM market_nse.market_candle_feature_fast ff
    WHERE ff.timeframe = 'week'
    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC
),
latest_day_market_pivot AS (
    SELECT DISTINCT ON (mp.instrument_id)
        mp.instrument_id,
        mp.pivot_type AS latest_market_pivot_type_day,
        mp.trend_pivot_type AS latest_market_trend_pivot_type_day,
        mp.pivot_price AS latest_market_pivot_price_day
    FROM market_nse.market_candle_pivot mp
    WHERE mp.timeframe = 'day'
    ORDER BY mp.instrument_id, mp.bar_start_ts DESC, mp.tf_id DESC
),
latest_day_core_pivot AS (
    SELECT DISTINCT ON (pm.instrument_id)
        pm.instrument_id,
        pm.pivot AS latest_pivot_type_day,
        pm.pivot_price AS latest_pivot_price_day,
        pm.timestamp AS latest_pivot_ts_day,
        pm.pivot_sequence AS latest_pivot_sequence_day
    FROM core_app_nse.pivot_metrics pm
    WHERE pm.timeframe = 'day'
    ORDER BY pm.instrument_id, pm.timestamp DESC, pm.pivot_sequence DESC
),
latest_day_core_trend_pivot AS (
    SELECT DISTINCT ON (tpm.instrument_id)
        tpm.instrument_id,
        tpm.trend_pivot AS latest_trend_pivot_type_day,
        tpm.pivot_price AS latest_trend_pivot_price_day,
        tpm.timestamp AS latest_trend_pivot_ts_day,
        tpm.pivot_sequence AS latest_trend_pivot_sequence_day
    FROM core_app_nse.trend_pivot_metrics tpm
    WHERE tpm.timeframe = 'day'
    ORDER BY tpm.instrument_id, tpm.timestamp DESC, tpm.pivot_sequence DESC
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
    CASE
        WHEN ldf.sma_5 > ldf.sma_10 AND ldf.sma_10 > ldf.sma_20 THEN 'BULL_STACK_5_10_20'
        WHEN ldf.sma_5 < ldf.sma_10 AND ldf.sma_10 < ldf.sma_20 THEN 'BEAR_STACK_5_10_20'
        ELSE 'MIXED_5_10_20'
    END AS sma_structure_day,
    CASE
        WHEN lhf.sma_5 > lhf.sma_10 AND lhf.sma_10 > lhf.sma_20 THEN 'BULL_STACK_5_10_20'
        WHEN lhf.sma_5 < lhf.sma_10 AND lhf.sma_10 < lhf.sma_20 THEN 'BEAR_STACK_5_10_20'
        ELSE 'MIXED_5_10_20'
    END AS sma_structure_hour,
    CASE
        WHEN lwf.sma_5 > lwf.sma_10 AND lwf.sma_10 > lwf.sma_20 THEN 'BULL_STACK_5_10_20'
        WHEN lwf.sma_5 < lwf.sma_10 AND lwf.sma_10 < lwf.sma_20 THEN 'BEAR_STACK_5_10_20'
        ELSE 'MIXED_5_10_20'
    END AS sma_structure_week,
    lcdp.latest_pivot_type_day,
    lcdtp.latest_trend_pivot_type_day,
    lmdp.latest_market_pivot_type_day,
    lmdp.latest_market_trend_pivot_type_day,
    CASE
        WHEN lcdtp.latest_trend_pivot_type_day IN ('HH', 'HL')
             AND ldf.sma_5 > ldf.sma_10
             AND ldf.sma_10 > ldf.sma_20
            THEN 'UPTREND'
        WHEN lcdtp.latest_trend_pivot_type_day IN ('LH', 'LL')
             AND ldf.sma_5 < ldf.sma_10
             AND ldf.sma_10 < ldf.sma_20
            THEN 'DOWNTREND'
        ELSE 'SIDEWAYS'
    END AS trend_state_day,
    CASE
        WHEN ldf.body_pct >= 75 AND ldf.lower_wick_pct >= 50 AND ldf.upper_wick_pct <= 10 THEN 'BOTTOM_TAIL'
        WHEN ldf.body_pct >= 75 AND ldf.upper_wick_pct >= 50 AND ldf.lower_wick_pct <= 10 THEN 'TOPPING_TAIL'
        WHEN ldf.body_pct >= 60 THEN 'STRONG_BODY'
        ELSE 'NEUTRAL'
    END AS current_candle_pattern_day,
    COALESCE(b.bootstrap_updated_at, now()) AS updated_at
FROM instrument_universe iu
LEFT JOIN bootstrap b ON b.instrument_id = iu.instrument_id
LEFT JOIN latest_day_candle ldc ON ldc.instrument_id = iu.instrument_id
LEFT JOIN latest_hour_candle lhc ON lhc.instrument_id = iu.instrument_id
LEFT JOIN latest_week_candle lwc ON lwc.instrument_id = iu.instrument_id
LEFT JOIN latest_day_fast ldf ON ldf.instrument_id = iu.instrument_id
LEFT JOIN latest_hour_fast lhf ON lhf.instrument_id = iu.instrument_id
LEFT JOIN latest_week_fast lwf ON lwf.instrument_id = iu.instrument_id
LEFT JOIN latest_day_market_pivot lmdp ON lmdp.instrument_id = iu.instrument_id
LEFT JOIN latest_day_core_pivot lcdp ON lcdp.instrument_id = iu.instrument_id
LEFT JOIN latest_day_core_trend_pivot lcdtp ON lcdtp.instrument_id = iu.instrument_id;
