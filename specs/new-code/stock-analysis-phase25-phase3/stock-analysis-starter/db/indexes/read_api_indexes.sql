CREATE INDEX IF NOT EXISTS idx_icb_instrument_id
    ON nse_exchange_symbol.instrument_chart_bootstrap (instrument_id);

CREATE INDEX IF NOT EXISTS idx_icb_chart_data_status
    ON nse_exchange_symbol.instrument_chart_bootstrap (chart_data_exists, bootstrap_status, chart_to_date);

CREATE INDEX IF NOT EXISTS idx_icb_updated_at
    ON nse_exchange_symbol.instrument_chart_bootstrap (updated_at DESC);

CREATE INDEX IF NOT EXISTS idx_icb_timeframes_gin
    ON nse_exchange_symbol.instrument_chart_bootstrap
    USING gin (chart_timeframes_available_json);

CREATE INDEX IF NOT EXISTS idx_market_candle_inst_tf_bar
    ON market_nse.market_candle (instrument_id, timeframe, bar_start_ts DESC);

CREATE INDEX IF NOT EXISTS idx_market_candle_inst_tf_tfid
    ON market_nse.market_candle (instrument_id, timeframe, tf_id DESC);

CREATE INDEX IF NOT EXISTS idx_fast_feature_inst_tf_bar
    ON market_nse.market_candle_feature_fast (instrument_id, timeframe, bar_start_ts DESC);

CREATE INDEX IF NOT EXISTS idx_market_pivot_inst_tf_bar
    ON market_nse.market_candle_pivot (instrument_id, timeframe, bar_start_ts DESC);

CREATE INDEX IF NOT EXISTS idx_core_pivot_inst_tf_ts
    ON core_app_nse.pivot_metrics (instrument_id, timeframe, timestamp DESC);

CREATE INDEX IF NOT EXISTS idx_core_pivot_inst_tf_seq
    ON core_app_nse.pivot_metrics (instrument_id, timeframe, pivot_sequence DESC);

CREATE INDEX IF NOT EXISTS idx_core_trend_pivot_inst_tf_ts
    ON core_app_nse.trend_pivot_metrics (instrument_id, timeframe, timestamp DESC);

CREATE INDEX IF NOT EXISTS idx_core_trend_pivot_inst_tf_seq
    ON core_app_nse.trend_pivot_metrics (instrument_id, timeframe, pivot_sequence DESC);
