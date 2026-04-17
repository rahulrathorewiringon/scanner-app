package com.rathore.stockanalysis.common.exchange;

import java.util.Objects;

public record ExchangeSchema(
        String exchangeCode,
        String masterSchema,
        String marketSchema,
        String coreAppSchema
) {
    public ExchangeSchema {
        Objects.requireNonNull(exchangeCode, "exchangeCode must not be null");
        Objects.requireNonNull(masterSchema, "masterSchema must not be null");
        Objects.requireNonNull(marketSchema, "marketSchema must not be null");
    }

    public boolean hasCoreAppSchema() {
        return coreAppSchema != null && !coreAppSchema.isBlank();
    }
}
