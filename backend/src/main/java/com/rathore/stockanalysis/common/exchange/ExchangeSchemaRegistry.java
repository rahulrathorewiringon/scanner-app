package com.rathore.stockanalysis.common.exchange;

import org.springframework.stereotype.Component;

import java.util.Locale;
import java.util.Map;

@Component
public class ExchangeSchemaRegistry {
    private static final Map<String, ExchangeSchema> MAP = Map.of(
            "NSE", new ExchangeSchema("NSE", "nse_exchange_symbol", "market_nse", "core_app_nse"),
            "BSE", new ExchangeSchema("BSE", "bse_exchange_symbol", "market_bse", null),
            "NFO", new ExchangeSchema("NFO", "nfo_exchange_symbol", "market_nfo", "core_app_nfo"),
            "BFO", new ExchangeSchema("BFO", "bfo_exchange_symbol", "market_bfo", null),
            "MCX", new ExchangeSchema("MCX", "mcx_exchange_symbol", "market_mcx", null)
    );

    public ExchangeSchema resolve(String exchangeCode) {
        if (exchangeCode == null || exchangeCode.isBlank()) {
            return MAP.get("NSE");
        }
        ExchangeSchema schema = MAP.get(exchangeCode.trim().toUpperCase(Locale.ROOT));
        if (schema == null) {
            throw new IllegalArgumentException("Unsupported exchangeCode=" + exchangeCode);
        }
        return schema;
    }
}
