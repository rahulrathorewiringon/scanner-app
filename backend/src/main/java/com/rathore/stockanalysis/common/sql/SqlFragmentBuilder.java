package com.rathore.stockanalysis.common.sql;

import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Set;

/**
 * Helper for assembling safe SQL fragments for read APIs.
 *
 * Notes:
 * - Schema names come only from ExchangeSchemaRegistry.
 * - Dynamic ORDER BY uses a field allowlist only.
 * - This class is intentionally fragment-oriented; repositories should still
 *   own full query assembly.
 */
@Component
public class SqlFragmentBuilder {

    private static final Set<String> INSTRUMENT_SORT_FIELDS = Set.of(
            "symbol",
            "instrument_id",
            "instrument_type",
            "chart_to_date",
            "trend_state_day",
            "latest_close_day",
            "updated_at"
    );

    private static final Map<String, String> INSTRUMENT_SORT_MAP = Map.of(
            "symbol", "snap.symbol",
            "instrument_id", "snap.instrument_id",
            "instrument_type", "snap.instrument_type",
            "chart_to_date", "snap.chart_to_date",
            "trend_state_day", "snap.trend_state_day",
            "latest_close_day", "snap.latest_close_day",
            "updated_at", "snap.updated_at"
    );

    public String latestBootstrapCte(ExchangeSchema schema) {
        return String.format(
            "latest_bootstrap AS (\n" +
            "    SELECT\n" +
            "        icb.instrument_id,\n" +
            "        icb.chart_data_exists,\n" +
            "        icb.bootstrap_status,\n" +
            "        icb.chart_data_status,\n" +
            "        icb.chart_from_date,\n" +
            "        icb.chart_to_date,\n" +
            "        icb.chart_timeframes_available_json,\n" +
            "        icb.reconcile_watermark_date,\n" +
            "        icb.bootstrap_completed_through_date,\n" +
            "        icb.last_bootstrap_completed_at,\n" +
            "        icb.last_reconcile_completed_at,\n" +
            "        icb.updated_at\n" +
            "    FROM %s.instrument_chart_bootstrap icb\n" +
            ")",
            schema.masterSchema()
        );
    }

    public String latestCandleCte(ExchangeSchema schema, String alias, String timeframe) {
        return String.format(
            "%s AS (\n" +
            "    SELECT DISTINCT ON (mc.instrument_id)\n" +
            "        mc.instrument_id,\n" +
            "        mc.trade_date,\n" +
            "        mc.tf_id,\n" +
            "        mc.bar_start_ts,\n" +
            "        mc.bar_end_ts,\n" +
            "        mc.open,\n" +
            "        mc.high,\n" +
            "        mc.low,\n" +
            "        mc.close,\n" +
            "        mc.volume,\n" +
            "        mc.updated_at\n" +
            "    FROM %s.market_candle mc\n" +
            "    WHERE mc.timeframe = '%s'\n" +
            "    ORDER BY mc.instrument_id, mc.bar_start_ts DESC, mc.tf_id DESC\n" +
            ")",
            alias, schema.marketSchema(), timeframe
        );
    }

    public String latestFastFeatureCte(ExchangeSchema schema, String alias, String timeframe) {
        return String.format(
            "%s AS (\n" +
            "    SELECT DISTINCT ON (ff.instrument_id)\n" +
            "        ff.instrument_id,\n" +
            "        ff.bar_start_ts,\n" +
            "        ff.sma_5,\n" +
            "        ff.sma_10,\n" +
            "        ff.sma_20,\n" +
            "        ff.sma_50,\n" +
            "        ff.sma_100,\n" +
            "        ff.sma_200,\n" +
            "        ff.atr_5,\n" +
            "        ff.atr_14,\n" +
            "        ff.atr_20,\n" +
            "        ff.range_to_atr,\n" +
            "        ff.body_pct,\n" +
            "        ff.upper_wick_pct,\n" +
            "        ff.lower_wick_pct\n" +
            "    FROM %s.market_candle_feature_fast ff\n" +
            "    WHERE ff.timeframe = '%s'\n" +
            "    ORDER BY ff.instrument_id, ff.bar_start_ts DESC, ff.tf_id DESC\n" +
            ")",
            alias, schema.marketSchema(), timeframe
        );
    }

    public String latestMarketPivotCte(ExchangeSchema schema, String alias, String timeframe) {
        return String.format(
            "%s AS (\n" +
            "    SELECT DISTINCT ON (mp.instrument_id)\n" +
            "        mp.instrument_id,\n" +
            "        mp.bar_start_ts,\n" +
            "        mp.pivot_type,\n" +
            "        mp.pivot_confirmed,\n" +
            "        mp.pivot_price,\n" +
            "        mp.trend_pivot_type\n" +
            "    FROM %s.market_candle_pivot mp\n" +
            "    WHERE mp.timeframe = '%s'\n" +
            "    ORDER BY mp.instrument_id, mp.bar_start_ts DESC, mp.tf_id DESC\n" +
            ")",
            alias, schema.marketSchema(), timeframe
        );
    }

    public String latestCorePivotMetricCte(ExchangeSchema schema, String alias, String timeframe) {
        if (!schema.hasCoreAppSchema()) {
            throw new IllegalStateException("coreAppSchema is required for pivot metric queries");
        }
        return String.format(
            "%s AS (\n" +
            "    SELECT DISTINCT ON (pm.instrument_id)\n" +
            "        pm.instrument_id,\n" +
            "        pm.symbol,\n" +
            "        pm.exchange_code,\n" +
            "        pm.timeframe,\n" +
            "        pm.tf_id,\n" +
            "        pm.pivot,\n" +
            "        pm.pivot_price,\n" +
            "        pm.timestamp,\n" +
            "        pm.pivot_sequence\n" +
            "    FROM %s.pivot_metrics pm\n" +
            "    WHERE pm.timeframe = '%s'\n" +
            "    ORDER BY pm.instrument_id, pm.timestamp DESC, pm.pivot_sequence DESC\n" +
            ")",
            alias, schema.coreAppSchema(), timeframe
        );
    }

    public String latestCoreTrendPivotMetricCte(ExchangeSchema schema, String alias, String timeframe) {
        if (!schema.hasCoreAppSchema()) {
            throw new IllegalStateException("coreAppSchema is required for trend pivot metric queries");
        }
        return String.format(
            "%s AS (\n" +
            "    SELECT DISTINCT ON (tpm.instrument_id)\n" +
            "        tpm.instrument_id,\n" +
            "        tpm.symbol,\n" +
            "        tpm.exchange_code,\n" +
            "        tpm.timeframe,\n" +
            "        tpm.tf_id,\n" +
            "        tpm.trend_pivot,\n" +
            "        tpm.pivot_price,\n" +
            "        tpm.timestamp,\n" +
            "        tpm.pivot_sequence\n" +
            "    FROM %s.trend_pivot_metrics tpm\n" +
            "    WHERE tpm.timeframe = '%s'\n" +
            "    ORDER BY tpm.instrument_id, tpm.timestamp DESC, tpm.pivot_sequence DESC\n" +
            ")",
            alias, schema.coreAppSchema(), timeframe
        );
    }

    public String instrumentUniverseBaseCte(ExchangeSchema schema) {
        return String.format(
            "instrument_universe AS (\n" +
            "    SELECT\n" +
            "        im.instrument_id,\n" +
            "        im.symbol,\n" +
            "        im.trading_symbol,\n" +
            "        im.instrument_type,\n" +
            "        im.is_active,\n" +
            "        im.source_entity_type,\n" +
            "        im.source_entity_id\n" +
            "    FROM %s.instrument_master im\n" +
            "    WHERE im.is_active = true\n" +
            ")",
            schema.masterSchema()
        );
    }

    public String safeInstrumentOrderBy(String sortField, String direction) {
        String normalizedField = (sortField == null || sortField.isBlank()) ? "symbol" : sortField;
        if (!INSTRUMENT_SORT_FIELDS.contains(normalizedField)) {
            normalizedField = "symbol";
        }
        String normalizedDirection = "desc".equalsIgnoreCase(direction) ? "DESC" : "ASC";
        return " ORDER BY " + INSTRUMENT_SORT_MAP.get(normalizedField) + " " + normalizedDirection + " ";
    }
}
