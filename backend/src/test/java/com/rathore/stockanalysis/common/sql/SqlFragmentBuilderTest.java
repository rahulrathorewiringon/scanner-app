package com.rathore.stockanalysis.common.sql;

import com.rathore.stockanalysis.common.exchange.ExchangeSchema;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SqlFragmentBuilderTest {
    private final SqlFragmentBuilder builder = new SqlFragmentBuilder();

    @Test
    void shouldBuildSafeOrderByWithAllowlistedField() {
        String orderBy = builder.safeInstrumentOrderBy("symbol", "desc");
        assertTrue(orderBy.contains("ORDER BY"));
        assertTrue(orderBy.contains("DESC"));
    }

    @Test
    void shouldFallbackOnUnknownSortField() {
        String orderBy = builder.safeInstrumentOrderBy("drop table", "asc");
        assertTrue(orderBy.contains("snap.symbol"));
    }

    @Test
    void shouldRequireCoreAppSchemaForCorePivotFragments() {
        ExchangeSchema schema = new ExchangeSchema("BSE", "bse_exchange_symbol", "market_bse", null);
        assertThrows(IllegalStateException.class, () -> builder.latestCorePivotMetricCte(schema, "x", "day"));
    }
}
