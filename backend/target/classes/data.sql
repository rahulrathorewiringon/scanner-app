-- Mock data for NSE instruments
INSERT INTO nse_exchange_symbol.instrument_master (instrument_id, exchange_code, symbol, trading_symbol, instrument_type, is_active) VALUES
(1, 'NSE', 'RELIANCE', 'RELIANCE', 'EQUITY', true),
(2, 'NSE', 'TCS', 'TCS', 'EQUITY', true),
(3, 'NSE', 'HDFC', 'HDFCBANK', 'EQUITY', true),
(4, 'NSE', 'INFY', 'INFY', 'EQUITY', true),
(5, 'NSE', 'ICICI', 'ICICIBANK', 'EQUITY', true),
(6, 'NSE', 'BAJAJ', 'BAJFINANCE', 'EQUITY', true),
(7, 'NSE', 'KOTAK', 'KOTAKBANK', 'EQUITY', true),
(8, 'NSE', 'LT', 'LT', 'EQUITY', true),
(9, 'NSE', 'MARUTI', 'MARUTI', 'EQUITY', true),
(10, 'NSE', 'ITC', 'ITC', 'EQUITY', true);

-- Mock chart bootstrap data
INSERT INTO nse_exchange_symbol.instrument_chart_bootstrap (instrument_id, chart_data_exists, bootstrap_status, chart_data_status, chart_from_date, chart_to_date, chart_timeframes_available_json) VALUES
(1, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(2, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(3, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(4, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(5, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(6, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(7, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(8, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(9, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]'),
(10, true, 'COMPLETED', 'COMPLETED', '2024-01-01', '2026-04-17', '["day", "week", "month"]');

-- Mock daily candle data for RELIANCE (last 30 days)
INSERT INTO market_nse.market_candle (instrument_id, timeframe, tf_id, bar_start_ts, trade_date, candle_week, open_price, high_price, low_price, close_price, volume) VALUES
(1, 'day', 1, '2026-03-18 09:15:00', '2026-03-18', '2026-03-17', 2500.00, 2520.00, 2480.00, 2510.00, 1000000),
(1, 'day', 2, '2026-03-19 09:15:00', '2026-03-19', '2026-03-17', 2510.00, 2530.00, 2490.00, 2520.00, 1200000),
(1, 'day', 3, '2026-03-20 09:15:00', '2026-03-20', '2026-03-17', 2520.00, 2540.00, 2500.00, 2530.00, 1100000),
(1, 'day', 4, '2026-03-21 09:15:00', '2026-03-21', '2026-03-17', 2530.00, 2550.00, 2510.00, 2540.00, 1300000),
(1, 'day', 5, '2026-03-24 09:15:00', '2026-03-24', '2026-03-24', 2540.00, 2560.00, 2520.00, 2550.00, 1400000),
(1, 'day', 6, '2026-03-25 09:15:00', '2026-03-25', '2026-03-24', 2550.00, 2570.00, 2530.00, 2560.00, 1250000),
(1, 'day', 7, '2026-03-26 09:15:00', '2026-03-26', '2026-03-24', 2560.00, 2580.00, 2540.00, 2570.00, 1350000),
(1, 'day', 8, '2026-03-27 09:15:00', '2026-03-27', '2026-03-24', 2570.00, 2590.00, 2550.00, 2580.00, 1450000),
(1, 'day', 9, '2026-03-28 09:15:00', '2026-03-28', '2026-03-24', 2580.00, 2600.00, 2560.00, 2590.00, 1500000),
(1, 'day', 10, '2026-03-31 09:15:00', '2026-03-31', '2026-03-31', 2590.00, 2610.00, 2570.00, 2600.00, 1600000),
(1, 'day', 11, '2026-04-01 09:15:00', '2026-04-01', '2026-03-31', 2600.00, 2620.00, 2580.00, 2610.00, 1550000),
(1, 'day', 12, '2026-04-02 09:15:00', '2026-04-02', '2026-03-31', 2610.00, 2630.00, 2590.00, 2620.00, 1650000),
(1, 'day', 13, '2026-04-03 09:15:00', '2026-04-03', '2026-03-31', 2620.00, 2640.00, 2600.00, 2630.00, 1700000),
(1, 'day', 14, '2026-04-04 09:15:00', '2026-04-04', '2026-03-31', 2630.00, 2650.00, 2610.00, 2640.00, 1750000),
(1, 'day', 15, '2026-04-07 09:15:00', '2026-04-07', '2026-04-07', 2640.00, 2660.00, 2620.00, 2650.00, 1800000),
(1, 'day', 16, '2026-04-08 09:15:00', '2026-04-08', '2026-04-07', 2650.00, 2670.00, 2630.00, 2660.00, 1850000),
(1, 'day', 17, '2026-04-09 09:15:00', '2026-04-09', '2026-04-07', 2660.00, 2680.00, 2640.00, 2670.00, 1900000),
(1, 'day', 18, '2026-04-10 09:15:00', '2026-04-10', '2026-04-07', 2670.00, 2690.00, 2650.00, 2680.00, 1950000),
(1, 'day', 19, '2026-04-11 09:15:00', '2026-04-11', '2026-04-07', 2680.00, 2700.00, 2660.00, 2690.00, 2000000),
(1, 'day', 20, '2026-04-14 09:15:00', '2026-04-14', '2026-04-14', 2690.00, 2710.00, 2670.00, 2700.00, 2100000),
(1, 'day', 21, '2026-04-15 09:15:00', '2026-04-15', '2026-04-14', 2700.00, 2720.00, 2680.00, 2710.00, 2050000),
(1, 'day', 22, '2026-04-16 09:15:00', '2026-04-16', '2026-04-14', 2710.00, 2730.00, 2690.00, 2720.00, 2150000),
(1, 'day', 23, '2026-04-17 09:15:00', '2026-04-17', '2026-04-14', 2720.00, 2740.00, 2700.00, 2730.00, 2200000);

-- Mock fast features for RELIANCE
INSERT INTO market_nse.market_candle_feature_fast (instrument_id, timeframe, bar_start_ts, sma_5, sma_10, sma_20, sma_50, sma_100, sma_200, atr_5, range_to_atr, body_pct, upper_wick_pct, lower_wick_pct) VALUES
(1, 'day', '2026-03-18 09:15:00', 2500.00, 2490.00, 2480.00, 2450.00, 2400.00, 2350.00, 25.00, 1.60, 0.80, 0.40, 0.40),
(1, 'day', '2026-03-19 09:15:00', 2505.00, 2495.00, 2485.00, 2455.00, 2405.00, 2355.00, 26.00, 1.54, 0.77, 0.38, 0.38),
(1, 'day', '2026-03-20 09:15:00', 2510.00, 2500.00, 2490.00, 2460.00, 2410.00, 2360.00, 27.00, 1.48, 0.74, 0.37, 0.37),
(1, 'day', '2026-03-21 09:15:00', 2515.00, 2505.00, 2495.00, 2465.00, 2415.00, 2365.00, 28.00, 1.43, 0.71, 0.36, 0.36),
(1, 'day', '2026-03-24 09:15:00', 2520.00, 2510.00, 2500.00, 2470.00, 2420.00, 2370.00, 29.00, 1.38, 0.69, 0.34, 0.34),
(1, 'day', '2026-03-25 09:15:00', 2525.00, 2515.00, 2505.00, 2475.00, 2425.00, 2375.00, 30.00, 1.33, 0.67, 0.33, 0.33),
(1, 'day', '2026-03-26 09:15:00', 2530.00, 2520.00, 2510.00, 2480.00, 2430.00, 2380.00, 31.00, 1.29, 0.65, 0.32, 0.32),
(1, 'day', '2026-03-27 09:15:00', 2535.00, 2525.00, 2515.00, 2485.00, 2435.00, 2385.00, 32.00, 1.25, 0.63, 0.31, 0.31),
(1, 'day', '2026-03-28 09:15:00', 2540.00, 2530.00, 2520.00, 2490.00, 2440.00, 2390.00, 33.00, 1.21, 0.61, 0.30, 0.30),
(1, 'day', '2026-03-31 09:15:00', 2545.00, 2535.00, 2525.00, 2495.00, 2445.00, 2395.00, 34.00, 1.18, 0.59, 0.29, 0.29),
(1, 'day', '2026-04-01 09:15:00', 2550.00, 2540.00, 2530.00, 2500.00, 2450.00, 2400.00, 35.00, 1.14, 0.57, 0.29, 0.29),
(1, 'day', '2026-04-02 09:15:00', 2555.00, 2545.00, 2535.00, 2505.00, 2455.00, 2405.00, 36.00, 1.11, 0.56, 0.28, 0.28),
(1, 'day', '2026-04-03 09:15:00', 2560.00, 2550.00, 2540.00, 2510.00, 2460.00, 2410.00, 37.00, 1.08, 0.54, 0.27, 0.27),
(1, 'day', '2026-04-04 09:15:00', 2565.00, 2555.00, 2545.00, 2515.00, 2465.00, 2415.00, 38.00, 1.05, 0.53, 0.26, 0.26),
(1, 'day', '2026-04-07 09:15:00', 2570.00, 2560.00, 2550.00, 2520.00, 2470.00, 2420.00, 39.00, 1.03, 0.51, 0.26, 0.26),
(1, 'day', '2026-04-08 09:15:00', 2575.00, 2565.00, 2555.00, 2525.00, 2475.00, 2425.00, 40.00, 1.00, 0.50, 0.25, 0.25),
(1, 'day', '2026-04-09 09:15:00', 2580.00, 2570.00, 2560.00, 2530.00, 2480.00, 2430.00, 41.00, 0.98, 0.49, 0.24, 0.24),
(1, 'day', '2026-04-10 09:15:00', 2585.00, 2575.00, 2565.00, 2535.00, 2485.00, 2435.00, 42.00, 0.95, 0.48, 0.24, 0.24),
(1, 'day', '2026-04-11 09:15:00', 2590.00, 2580.00, 2570.00, 2540.00, 2490.00, 2440.00, 43.00, 0.93, 0.47, 0.23, 0.23),
(1, 'day', '2026-04-14 09:15:00', 2595.00, 2585.00, 2575.00, 2545.00, 2495.00, 2445.00, 44.00, 0.91, 0.45, 0.23, 0.23),
(1, 'day', '2026-04-15 09:15:00', 2600.00, 2590.00, 2580.00, 2550.00, 2500.00, 2450.00, 45.00, 0.89, 0.44, 0.22, 0.22),
(1, 'day', '2026-04-16 09:15:00', 2605.00, 2595.00, 2585.00, 2555.00, 2505.00, 2455.00, 46.00, 0.87, 0.43, 0.22, 0.22),
(1, 'day', '2026-04-17 09:15:00', 2610.00, 2600.00, 2590.00, 2560.00, 2510.00, 2460.00, 47.00, 0.85, 0.43, 0.21, 0.21);

-- Mock pivot data for RELIANCE
INSERT INTO market_nse.market_candle_pivot (instrument_id, timeframe, bar_start_ts, pivot_type, pivot_left_arm_length, pivot_right_arm_length, pivot_left_arm_strength, pivot_right_arm_strength, trend_pivot_type, trend_left_arm_length, trend_right_arm_length, trend_left_arm_strength, trend_right_arm_strength) VALUES
(1, 'day', '2026-03-18 09:15:00', 'HIGH', 2, 1, 3, 2, 'HIGH', 5, 3, 8, 5),
(1, 'day', '2026-03-19 09:15:00', 'LOW', 1, 2, 2, 3, 'LOW', 3, 4, 5, 7),
(1, 'day', '2026-03-20 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-03-21 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-03-24 09:15:00', 'HIGH', 3, 2, 4, 3, 'HIGH', 6, 4, 9, 6),
(1, 'day', '2026-03-25 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-03-26 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-03-27 09:15:00', 'LOW', 2, 3, 3, 4, 'LOW', 4, 5, 6, 8),
(1, 'day', '2026-03-28 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-03-31 09:15:00', 'HIGH', 4, 1, 5, 2, 'HIGH', 7, 2, 10, 3),
(1, 'day', '2026-04-01 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-02 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-03 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-04 09:15:00', 'LOW', 3, 2, 4, 3, 'LOW', 5, 3, 7, 5),
(1, 'day', '2026-04-07 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-08 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-09 09:15:00', 'HIGH', 2, 3, 3, 4, 'HIGH', 4, 5, 6, 7),
(1, 'day', '2026-04-10 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-11 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-14 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-15 09:15:00', 'LOW', 1, 4, 2, 5, 'LOW', 2, 6, 3, 9),
(1, 'day', '2026-04-16 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1, 'day', '2026-04-17 09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Mock data for other instruments (simplified)
INSERT INTO market_nse.market_candle (instrument_id, timeframe, tf_id, bar_start_ts, trade_date, candle_week, open_price, high_price, low_price, close_price, volume) VALUES
(2, 'day', 1, '2026-04-17 09:15:00', '2026-04-17', '2026-04-14', 3200.00, 3250.00, 3180.00, 3240.00, 800000),
(3, 'day', 1, '2026-04-17 09:15:00', '2026-04-17', '2026-04-14', 1600.00, 1620.00, 1580.00, 1610.00, 600000),
(4, 'day', 1, '2026-04-17 09:15:00', '2026-04-17', '2026-04-14', 1400.00, 1420.00, 1380.00, 1410.00, 500000),
(5, 'day', 1, '2026-04-17 09:15:00', '2026-04-17', '2026-04-14', 950.00, 970.00, 930.00, 960.00, 400000);

-- Mock saved screener
INSERT INTO app_ui.saved_screener_definition (screener_id, user_id, name, exchange_code, trade_date, default_timeframe, filter_tree, sort_spec, page_size) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'test_user', 'Large Cap Stocks', 'NSE', '2026-04-17', 'day',
 '{"type": "and", "conditions": [{"field": "close_price", "operator": "gt", "value": 1000}]}',
 '{"field": "close_price", "direction": "desc"}', 50);

-- Mock watchlist
INSERT INTO app_ui.watchlist_definition (watchlist_id, user_id, name, exchange_code, watchlist_type) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'test_user', 'My Favorites', 'NSE', 'MANUAL');

INSERT INTO app_ui.watchlist_item (watchlist_item_id, watchlist_id, instrument_id, note) VALUES
('550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 1, 'Primary holding'),
('550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 2, 'Tech sector');

-- Mock alert rule
INSERT INTO app_ui.alert_rule (alert_rule_id, user_id, exchange_code, instrument_id, rule_name, rule_type, status, config_json) VALUES
('550e8400-e29b-41d4-a716-446655440004', 'test_user', 'NSE', 1, 'Price Alert', 'PRICE_THRESHOLD', 'ACTIVE',
 '{"threshold": 2700.00, "condition": "above"}');

-- Mock workspace preset
INSERT INTO app_ui.workspace_layout_preset (preset_id, user_id, name, exchange_code, layout_json, is_default) VALUES
('550e8400-e29b-41d4-a716-446655440005', 'test_user', 'Default Layout', 'NSE',
 '{"global": {}, "borders": [], "layout": {"type": "row", "weight": 100, "children": []}}', true);