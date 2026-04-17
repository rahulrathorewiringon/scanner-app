package com.rathore.stockanalysis.common.exchange;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ExchangeSchemaRegistryTest {
    private final ExchangeSchemaRegistry registry = new ExchangeSchemaRegistry();

    @Test
    void shouldResolveNseSchemas() {
        ExchangeSchema schema = registry.resolve("NSE");
        assertEquals("nse_exchange_symbol", schema.masterSchema());
        assertEquals("market_nse", schema.marketSchema());
        assertEquals("core_app_nse", schema.coreAppSchema());
    }

    @Test
    void shouldDefaultToNseWhenBlank() {
        ExchangeSchema schema = registry.resolve("");
        assertEquals("NSE", schema.exchangeCode());
    }

    @Test
    void shouldRejectUnsupportedExchange() {
        assertThrows(IllegalArgumentException.class, () -> registry.resolve("FOO"));
    }
}
