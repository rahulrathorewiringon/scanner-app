package com.rathore.stockanalysis.common.exchange;

import java.util.Map;
import org.springframework.stereotype.Component;

@Component
public class ExchangeSchemaRegistry {
    private static final Map<String, ExchangeSchema> MAP = Map.of(
        "NSE", new ExchangeSchema("nse_exchange_symbol", "market_nse"),
        "BSE", new ExchangeSchema("bse_exchange_symbol", "market_bse"),
        "NFO", new ExchangeSchema("nfo_exchange_symbol", "market_nfo"),
        "BFO", new ExchangeSchema("bfo_exchange_symbol", "market_bfo"),
        "MCX", new ExchangeSchema("mcx_exchange_symbol", "market_mcx")
    );

    public ExchangeSchema resolve(String exchangeCode) {
        if (exchangeCode == null || exchangeCode.isBlank()) {
            throw new IllegalArgumentException("exchangeCode is required");
        }
        ExchangeSchema schema = MAP.get(exchangeCode.toUpperCase());
        if (schema == null) {
            throw new IllegalArgumentException("Unsupported exchangeCode=" + exchangeCode);
        }
        return schema;
    }
}
