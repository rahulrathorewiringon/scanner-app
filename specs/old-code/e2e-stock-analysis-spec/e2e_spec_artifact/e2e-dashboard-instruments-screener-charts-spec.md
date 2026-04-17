# End-to-End Development Specification

This artifact defines the end-to-end flow for the stock-analysis platform across backend APIs, SQL/query design, Java service/repository contracts, frontend TypeScript DTOs/hooks, and test coverage.

It is aligned to the uploaded schema and migration notes:
- Canonical candles: `market_<exchange>.market_candle`
- Instrument universe: `<exchange>_exchange_symbol.instrument_master`
- Data availability/orchestration: `<exchange>_exchange_symbol.instrument_chart_bootstrap`
- Exchange-aware schema resolution for all runtime reads

## 1. Scope

Routes in scope:
- `/analytics/dashboard`
- `/analytics/instruments`
- `/analytics/instruments/[instrumentId]/summary`
- `/analytics/instruments/[instrumentId]/charts`
- `/analytics/screeners`
- `/analytics/pivot-chart`

## 2. Source-of-truth mapping

### 2.1 Instrument universe
Use `<exchange>_exchange_symbol.instrument_master` as the canonical source of:
- `instrument_id`
- `symbol`
- `trading_symbol`
- `instrument_type`
- `is_active`
- related sector/industry enrichment tables where available

### 2.2 Data availability
Use `<exchange>_exchange_symbol.instrument_chart_bootstrap` as the source of:
- `chart_data_exists`
- `chart_timeframes_available_json`
- `bootstrap_status`
- `chart_data_status`
- `chart_from_date`
- `chart_to_date`
- `reconcile_watermark_date`
- bootstrap/reconcile completion timestamps

### 2.3 Canonical candles
Use `market_<exchange>.market_candle` as the only canonical price/candle source for charts and latest price summaries.

### 2.4 Derived analytics
Use derived Phase B+ tables and read-models for:
- trend state
- pivot summary
- SMA structure
- candle pattern labels
- signal/execution labels

## 3. End-to-end request flow

```text
React page
  -> TanStack Query hook
  -> REST controller
  -> Service
  -> Query repository / SQL builder
  -> PostgreSQL
  -> normalized DTO
  -> Zustand + React render
```

## 4. Backend architecture

```text
com.rathore.stockanalysis
  .common.exchange
  .dashboard
  .instrument
  .screener
  .chart
```

### 4.1 ExchangeSchemaRegistry
Centralize schema resolution by `exchangeCode`.

Responsibilities:
- resolve `masterSchema`
- resolve `marketSchema`
- reject unsupported exchanges

## 5. Backend API specification

### 5.1 Dashboard

#### GET `/api/analytics/dashboard-overview`
Params:
- `exchangeCode`
- `tradeDate`
- `timeframe`

Response:
- total active instruments
- instruments with chart data
- uptrend/downtrend/sideways counts
- timeframe coverage
- sector trend buckets
- latest chart/bootstrap freshness metadata

#### GET `/api/analytics/data-coverage`
Params:
- `exchangeCode`

Response:
- chartDataExists count
- stale count
- rebuild-required count
- counts by bootstrap status
- counts by timeframe availability

### 5.2 Instruments

#### POST `/api/analytics/instruments/search`
Request:
- `exchangeCode`
- `tradeDate`
- trend/timeframe/sector/symbol filters
- pagination
- sort

Response:
- paginated `InstrumentRowDto[]`
- total rows

#### GET `/api/instruments/{instrumentId}/summary`
Params:
- `exchangeCode`
- `tradeDate`

Response sections:
- identity
- dataAvailability
- latestPrices
- trend
- pivots
- smaStructure
- candleAnalysis

### 5.3 Screener

#### GET `/api/screener/filter-metadata`
Returns supported filter groups, fields, operators, and enums.

#### POST `/api/screener/count`
Returns result count for a filter tree.

#### POST `/api/screener/run`
Returns paginated screener results.

All screener queries must pre-filter instruments via `instrument_chart_bootstrap.chart_data_exists = true`.

### 5.4 Charts

#### GET `/api/instruments/{instrumentId}/charts`
Params:
- `exchangeCode`
- `timeframes=week,day,hour`
- `from`
- `to`
- `includeSma`
- `includePivots`
- `includePivotCandles`

Returns:
- week/day/hour candle series
- optional SMA overlays
- optional pivot markers

## 6. SQL/query design

### 6.1 Dashboard overview base pattern

```sql
WITH universe AS (
  SELECT im.instrument_id, im.symbol
  FROM {{masterSchema}}.instrument_master im
  JOIN {{masterSchema}}.instrument_chart_bootstrap icb
    ON icb.instrument_id = im.instrument_id
  WHERE im.is_active = true
),
with_data AS (
  SELECT *
  FROM universe u
  JOIN {{masterSchema}}.instrument_chart_bootstrap icb
    ON icb.instrument_id = u.instrument_id
  WHERE icb.chart_data_exists = true
)
SELECT COUNT(*) FROM with_data;
```

Join latest trend snapshot from an app-level read model such as `app_ui.instrument_latest_snapshot`.

### 6.2 Instruments search base pattern

```sql
SELECT
  im.instrument_id,
  im.symbol,
  im.trading_symbol,
  im.instrument_type,
  icb.chart_data_exists,
  icb.chart_timeframes_available_json,
  icb.bootstrap_status,
  icb.chart_data_status,
  icb.chart_to_date
FROM {{masterSchema}}.instrument_master im
JOIN {{masterSchema}}.instrument_chart_bootstrap icb
  ON icb.instrument_id = im.instrument_id
WHERE im.is_active = true
  AND icb.chart_data_exists = true;
```

### 6.3 Charts base pattern

```sql
SELECT instrument_id, timeframe, tf_id, bar_start_ts, bar_end_ts, trade_date,
       open, high, low, close, volume
FROM {{marketSchema}}.market_candle
WHERE instrument_id = :instrumentId
  AND timeframe = :timeframe
ORDER BY bar_start_ts;
```

Optional overlays from:
- `{{marketSchema}}.market_candle_feature_fast`
- `{{marketSchema}}.market_candle_pivot`

## 7. Java service design

### 7.1 DashboardService
- `DashboardOverviewDto getOverview(...)`
- `DataCoverageDto getDataCoverage(...)`

### 7.2 InstrumentService
- `PagedResponse<InstrumentRowDto> search(...)`
- `InstrumentSummaryDto getSummary(...)`

### 7.3 ScreenerService
- `ScreenerFilterMetadataDto getFilterMetadata(...)`
- `long count(...)`
- `PagedResponse<ScreenerResultRowDto> run(...)`

### 7.4 ChartService
- `MultiTimeframeChartsDto getCharts(...)`

## 8. Frontend TS contract design

### 8.1 Shared enums
- `ExchangeCode`
- `Timeframe`
- `TrendState`

### 8.2 DTOs
Provide typed DTOs for:
- dashboard overview
- data coverage
- instrument search rows
- instrument summary
- screener metadata/request/response
- chart series/overlays

### 8.3 Hooks
Required hooks:
- `useDashboardOverviewQuery`
- `useDataCoverageQuery`
- `useInstrumentSearchQuery`
- `useInstrumentSummaryQuery`
- `useScreenerFilterMetadataQuery`
- `useScreenerCountMutation`
- `useScreenerRunMutation`
- `useMultiTimeframeChartsQuery`

## 9. Suggested read models

Introduce app-level read models such as:
- `app_ui.instrument_latest_snapshot`
- `app_ui.instrument_pivot_sequence_latest`
- `app_ui.instrument_trend_distribution_daily`

This keeps dashboard, instruments, and screener queries fast and normalized.

## 10. Testing specification

### 10.1 Backend unit tests
- `ExchangeSchemaRegistryTest`
- `DashboardServiceTest`
- `InstrumentServiceTest`
- `ScreenerFilterCompilerTest`
- `ChartServiceTest`

### 10.2 Backend integration tests
Use Testcontainers PostgreSQL.

Coverage:
- dashboard aggregates
- instrument search filters/pagination/sort
- instrument summary composition
- multi-timeframe chart query correctness
- screener filter execution with bootstrap pre-filter

### 10.3 Frontend unit tests
Use Vitest + Testing Library.

Coverage:
- dashboard KPI cards
- instruments table actions
- summary sections with partial data
- chart toggles and summary strip
- screener filter builder

### 10.4 Frontend integration tests
Use MSW.

Coverage:
- dashboard load and KPI navigation
- instruments table + drawer flow
- charts page with week/day/hour series
- screener metadata/count/run flow

## 11. Performance and indexing recommendations

Verify indexes on:
- `{{marketSchema}}.market_candle (instrument_id, timeframe, bar_start_ts)`
- `{{marketSchema}}.market_candle_feature_fast (instrument_id, timeframe, bar_start_ts)`
- `{{marketSchema}}.market_candle_pivot (instrument_id, timeframe, bar_start_ts)`
- `{{masterSchema}}.instrument_chart_bootstrap (instrument_id, chart_data_exists, bootstrap_status)`
- `app_ui.instrument_latest_snapshot (exchange_code, trade_date, timeframe, instrument_id)`

## 12. Final implementation rules

- Never use legacy `exchange_symbol.*`.
- Always resolve schemas from `exchangeCode`.
- Treat `instrument_chart_bootstrap` as the availability contract.
- Treat `market_<exchange>.market_candle` as the canonical chart source.
- Keep trend, pivot labels, candle labels, and SMA structure on backend-normalized DTOs.
