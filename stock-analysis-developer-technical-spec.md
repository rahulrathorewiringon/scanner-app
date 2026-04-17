# Stock Analysis Platform — Developer Technical Specification
Generated: 2026-04-17 16:52:03

## 1. Purpose of this document

This document is a **coding-agent-oriented technical specification** for the current stock-analysis codebase. It is designed to help a coding agent:

- understand the project structure quickly
- identify the **canonical source files and module boundaries**
- avoid editing duplicate or legacy files by mistake
- understand how backend and frontend are supposed to interact
- diagnose current merge/compile risks
- implement fixes and new features safely

This spec reflects the **current combined repo baseline** represented by the latest packaged project, not only the intended target architecture.

---

## 2. High-level product and architecture

This repository contains a stock-analysis workstation with:

- **Backend**: Spring Boot 3 / Java 21 / JDBC / PostgreSQL
- **Frontend**: React 18 / TypeScript / Vite / React Query / Zustand
- **Desktop wrapper**: Tauri 2
- **Charting / workspace UX**:
  - FlexLayout for dockable workspace
  - Lightweight Charts for MTF charting
- **Runtime model**:
  - backend owns analytics execution and persistence
  - frontend is a rendering/orchestration client
  - desktop mode is a wrapper around the same frontend app

Core user-facing domains already present in the codebase:
- dashboard
- instruments / instrument summary
- screener
- workspace / multi-timeframe charts
- watchlists
- alerts
- user preferences
- workspace presets
- screener sharing / tagging
- watchlist generation rules
- audit/history
- authorization / permission checks

---

## 3. Canonical repo structure

The repo is split into two main projects.

```text
backend/
frontend/
```

### Backend canonical root
```text
backend/src/main/java/com/rathore/stockanalysis/
```

### Frontend canonical root
```text
frontend/src/
```

### Desktop canonical root
```text
frontend/src-tauri/
```

---

## 4. Very important: canonical vs non-canonical frontend paths

The current repo still contains **duplicate or legacy top-level frontend folders** outside `frontend/src/`, for example:

```text
frontend/chart-workbench/
frontend/hooks/
frontend/stores/
frontend/types/
frontend/workspace-layout/
```

The **canonical application code** should be treated as:

```text
frontend/src/...
```

A coding agent should follow this rule:

### Canonical frontend edit rule
- Prefer editing files under `frontend/src/**`
- Treat top-level `frontend/chart-workbench`, `frontend/hooks`, `frontend/stores`, `frontend/types`, `frontend/workspace-layout` as **legacy/mirrored/cleanup candidates** unless a build import clearly points to them

### Canonical backend edit rule
- Prefer files under `backend/src/main/java/**`
- Ignore duplicate suffixed files such as `SomeFile (2).java`, `SomeFile (3).java`, etc.
- These are merge artifacts and should not be reintroduced

---

## 5. Current backend package map

Current backend packages present:

```text
com.rathore.stockanalysis
  adminjobs
  alert
  audit
  authz
  chart
  common
  dashboard
  instrument
  preference
  rulelab
  screener
  watchlist
```

### Main application
- `backend/src/main/java/com/rathore/stockanalysis/StockAnalysisBackendApplication.java`

### Common package
- `common/exchange` → exchange/schema resolution
- `common/sql` → SQL fragment helpers
- `common/errors` and `common/web` → exception handling

### Domain packages
- `dashboard` → overview and data coverage APIs
- `instrument` → instruments search and summary
- `chart` → MTF chart series and overlays
- `screener` → filter metadata / count / run
- `preference` → saved screeners, shares, presets, bulk actions
- `watchlist` → watchlists, watchlist items, generation rules, alert rules
- `audit` → timeline/history read APIs
- `authz` → permission enforcement service

---

## 6. Current frontend package map

Canonical frontend package map under `frontend/src/`:

```text
src/
  alerts/
  app-shell/
  chart-workbench/
  dashboard/
  hooks/
  instruments/
  lib/
  platform/
  routes/
  screener/
  stores/
  types/
  watchlists/
  workspace-layout/
```

### Main entry
- `frontend/src/main.tsx`

### Root routes
- `frontend/src/routes/App.tsx`

### App shell
- `frontend/src/app-shell/AppShell.tsx`

### Main pages currently wired
- `dashboard/DashboardPage.tsx`
- `instruments/InstrumentsPage.tsx`
- `instruments/InstrumentSummaryPage.tsx`
- `screener/ScreenerPage.tsx`
- `workspace-layout/DockingWorkspace.tsx`
- `workspace-layout/WorkspacePresetManagementPage.tsx`
- `watchlists/WatchlistsPage.tsx`
- `watchlists/WatchlistDetailPage.tsx`
- `watchlists/WatchlistTimelinePage.tsx`
- `alerts/AlertsPage.tsx`
- `alerts/AlertDetailPage.tsx`
- `alerts/AlertTimelinePage.tsx`

---

## 7. Backend runtime and data assumptions

The intended schema model for production is exchange-aware, with **NSE-first** defaults.

Expected schema families:

- master/bootstrap: `nse_exchange_symbol`
- market candles/features/pivots: `market_nse`
- higher-level analytics summary: `core_app_nse`
- app UI / user preference / audit tables: `app_ui`

### Expected canonical source mapping
- instrument universe → `nse_exchange_symbol.instrument_master`
- availability → `nse_exchange_symbol.instrument_chart_bootstrap`
- candles → `market_nse.market_candle`
- fast features → `market_nse.market_candle_feature_fast`
- bar-level pivots → `market_nse.market_candle_pivot`
- higher-level pivot summary → `core_app_nse.pivot_metrics`
- higher-level trend pivot summary → `core_app_nse.trend_pivot_metrics`

### Important implementation note
The current cleaned repo includes config and code that assume this mapping, but the repo may still be missing some SQL artifacts physically in-tree. A coding agent should not assume all DB bootstrap/readmodel files are already present unless verified.

---

## 8. Current backend HTTP API surface

### Dashboard
Base:
```text
/api/analytics
```

Endpoints:
- `GET /api/analytics/dashboard-overview`
- `GET /api/analytics/data-coverage`

### Instruments
Base:
```text
/api
```

Endpoints:
- `POST /api/analytics/instruments/search`
- `GET /api/instruments/{instrumentId}/summary`

### Charts
Base:
```text
/api/instruments`
```

Endpoints:
- `GET /api/instruments/{instrumentId}/charts`

### Screener
Base:
```text
/api/screener
```

Endpoints:
- `GET /api/screener/filter-metadata`
- `POST /api/screener/count`
- `POST /api/screener/run`

### Saved screeners / bulk actions / workspace presets
Base:
```text
/api
```

Endpoints include:
- `GET /api/screener/saved-definitions`
- `GET /api/screener/shared-definitions`
- `POST /api/screener/saved-definitions`
- `PUT /api/screener/saved-definitions/{screenerId}`
- `DELETE /api/screener/saved-definitions/{screenerId}`
- `GET /api/screener/saved-definitions/{screenerId}/tags`
- `PUT /api/screener/saved-definitions/{screenerId}/tags`
- `GET /api/screener/saved-definitions/{screenerId}/shares`
- `POST /api/screener/saved-definitions/{screenerId}/shares`
- `PUT /api/screener/saved-definitions/{screenerId}/shares`
- `DELETE /api/screener/saved-definitions/{screenerId}/shares`
- `POST /api/screener/bulk-actions`

Workspace preset endpoints:
- `GET /api/workspace/layout-presets`
- `GET /api/workspace/shared-layout-presets`
- `POST /api/workspace/layout-presets`
- `PUT /api/workspace/layout-presets/{presetId}`
- `POST /api/workspace/layout-presets/{presetId}/default`
- `POST /api/workspace/layout-presets/{presetId}/favorite`
- `DELETE /api/workspace/layout-presets/{presetId}`
- `GET /api/workspace/layout-presets/{presetId}/shares`
- `POST /api/workspace/layout-presets/{presetId}/shares`
- `PUT /api/workspace/layout-presets/{presetId}/shares`
- `DELETE /api/workspace/layout-presets/{presetId}/shares`

### Watchlists / alerts
Base:
```text
/api
```

Watchlist endpoints:
- `GET /api/watchlists`
- `POST /api/watchlists`
- `GET /api/watchlists/{watchlistId}`
- `PUT /api/watchlists/{watchlistId}`
- `DELETE /api/watchlists/{watchlistId}`
- `GET /api/watchlists/{watchlistId}/items`
- `POST /api/watchlists/{watchlistId}/items`
- `PUT /api/watchlists/{watchlistId}/items/{watchlistItemId}`
- `DELETE /api/watchlists/{watchlistId}/items/{watchlistItemId}`
- `GET /api/watchlists/rules`
- `POST /api/watchlists/rules`
- `PUT /api/watchlists/rules/{ruleId}`
- `DELETE /api/watchlists/rules/{ruleId}`
- `POST /api/watchlists/rules/{ruleId}/generate`

Alert endpoints:
- `GET /api/alerts/rules`
- `GET /api/alerts/rules/{alertRuleId}`
- `PUT /api/alerts/rules/{alertRuleId}`
- `DELETE /api/alerts/rules/{alertRuleId}`
- `PUT /api/alerts/rules/{alertRuleId}/status`

### Audit
Base:
```text
/api/audit
```

Endpoints:
- `GET /api/audit/watchlists/{watchlistId}`
- `GET /api/audit/alerts/{alertRuleId}`

---

## 9. Current frontend route map

Current main route map in `frontend/src/routes/App.tsx`:

```text
/
  -> DashboardPage

/instruments
/instruments/:instrumentId/summary

/screener

/workspace
/workspace/presets

/watchlists
/watchlists/:watchlistId
/watchlists/:watchlistId/timeline

/alerts
/alerts/:alertRuleId
/alerts/:alertRuleId/timeline

/rule-lab
/snapshot-inspector
/admin
```

`rule-lab`, `snapshot-inspector`, and `admin` are still placeholders in the current routed app.

---

## 10. State management strategy

### Frontend state libraries
- server state → React Query
- client/session/workspace state → Zustand

### Main active store in current codebase
- `frontend/src/stores/workspace.store.ts`

This store currently acts as a de facto global workspace/session store and contains:
- exchange code
- trade date
- active instrument
- selected timeframes
- sync state
- crosshair/hover state
- workspace model state

### Coding-agent rule
Do **not** introduce overlapping global stores without a strong reason.  
Prefer extending `workspace.store.ts` or adding clearly scoped stores under `src/stores/`.

---

## 11. Charting and workspace model

### Charting stack
- Lightweight Charts
- custom sync manager:
  - `frontend/src/chart-workbench/SynchronizedChartManager.ts`

### Workspace stack
- FlexLayout
- main workspace host:
  - `frontend/src/workspace-layout/DockingWorkspace.tsx`

### Intended workspace capabilities
- week/day/hour chart panes
- synchronized visible range
- synchronized hover/crosshair state
- timeline / marker views
- symbol context side panel
- preset loading/saving/sharing

### Current coding-agent note
The workspace is functional as a scaffold, but **chart/workspace behavior is the area most likely to have partial implementations and drift** after many incremental merges.

When changing workspace behavior:
1. inspect `DockingWorkspace.tsx`
2. inspect `SynchronizedChartManager.ts`
3. inspect `workspace.store.ts`
4. inspect `WorkspacePresetManagementPage.tsx`

Change all 4 together if the feature crosses layout + chart sync + state.

---

## 12. Saved screeners and workspace preset model

### Saved screeners
Backend ownership:
- preference package
- persistence via `app_ui` preference tables

Frontend ownership:
- `ScreenerPage.tsx`
- `useSavedScreeners...`
- `useSavedScreenerCollaboration...`

Expected concerns:
- save
- update
- delete
- tags
- shares
- share permission editing
- “shared with me” view

### Workspace presets
Backend ownership:
- preference package
- workspace preset CRUD/share endpoints

Frontend ownership:
- `WorkspacePresetManagementPage.tsx`
- workspace preset hooks
- `DockingWorkspace.tsx`

Expected concerns:
- save
- update
- delete
- mark default
- mark favorite
- share
- share permission editing

---

## 13. Watchlists / alerts / rules / audit model

### Watchlists
The watchlist domain includes:
- watchlist definition
- watchlist items
- watchlist generation rules stored as JSON
- generation execution that reuses screener-style logic

### Alerts
The alert domain includes:
- persisted alert rules
- update/delete/status change
- audit timelines

### Audit
The audit layer should record:
- watchlist create/update/delete
- watchlist item add/update/delete
- alert rule update/delete/status change
- optionally bulk action derived events

### Important coding-agent rule
If you add or change any mutating watchlist or alert flow:
- update the service implementation
- update audit recording
- update integration tests
- update the corresponding detail/timeline pages if the change affects user visibility

---

## 14. Authorization and permissions model

Current authorization layer:
- backend `authz` package
- service: `AuthorizationService`

Current permission model is intended to support:
- ownership
- shared access
- role-based override via `user_role_assignment`
- `VIEW` vs `EDIT` permissions

### Current limitation
The repo has authorization support, but after multiple merges, it should be treated as **partially hardened**, not guaranteed complete.

### Coding-agent rule
Whenever adding a new mutation on:
- saved screeners
- screener shares
- workspace presets
- workspace preset shares

you must explicitly verify:
1. owner path
2. shared-edit path
3. admin override path
4. forbidden path

---

## 15. Current testing structure

### Backend tests
Current backend test classes include:
- `ExchangeSchemaRegistryTest`
- `SqlFragmentBuilderTest`
- `AuthorizationServiceImplTest`
- `DashboardQueryRepositoryIT`
- `InstrumentQueryRepositoryIT`
- `ChartQueryRepositoryIT`
- `ScreenerQueryRepositoryIT`
- `UserPreferenceRepositoryIT`
- `WatchlistConsoleRepositoryIT`
- `AuditRepositoryIT`
- `PostgresIntegrationTestSupport`

### Frontend tests
Current frontend tests are still relatively light:
- `workspace.store.test.ts`
- `DesktopBridge.test.ts`

### Coding-agent rule
If you add a backend repository/service feature:
- add at least one repository integration test if SQL/persistence changes
- add one focused unit test if logic is branchy

If you add a frontend interaction flow:
- add at least one store/hook/component test if the behavior is stateful

---

## 16. Known technical debt and risks

### A. Duplicate/legacy files
There are multiple duplicate and legacy files in the project history and possibly still in the repo tree.

Rule:
- delete or ignore suffixed duplicates like ` (2)`, ` (3)`, etc.
- never branch new work from those files

### B. Duplicate backend exception handler package
There are both:
- `common/errors/ApiExceptionHandler.java`
- `common/web/ApiExceptionHandler.java`

A coding agent should verify which one is actually active and consolidate later.

### C. Duplicate/overlapping frontend folders
There are both:
- canonical: `frontend/src/...`
- non-canonical: `frontend/chart-workbench`, `frontend/hooks`, `frontend/stores`, `frontend/types`, `frontend/workspace-layout`

Treat `frontend/src/...` as canonical unless imports prove otherwise.

### D. SQL/readmodel artifacts not fully standardized in-tree
The repo appears to rely on `scripts/dev/apply_readmodels.sh`, but the complete `db/readmodels/` tree may not be consistently present in the latest cleaned package.

### E. Incremental merge drift
Because this repo has been built through many iterative patch-style updates, a coding agent should expect:
- mismatched DTO names
- duplicate hooks
- stale imports
- controller/service signatures drifting from one another

---

## 17. Canonical coding rules for future changes

### Rule 1 — Prefer canonical frontend paths
Only edit under:
```text
frontend/src/**
```
unless the imports/build definitely point somewhere else.

### Rule 2 — Don’t trust duplicate suffixed files
Files with ` (2)`, ` (3)`, etc. are merge artifacts. Do not edit them. Remove them if safe.

### Rule 3 — For backend API changes, edit vertically
For each backend feature, inspect and update all of:
- controller
- service interface
- service impl
- repository interface
- repository impl
- DTOs
- tests

### Rule 4 — For frontend feature changes, edit horizontally
For each frontend feature, inspect and update:
- route/page
- hooks
- store
- types
- any related workspace/chart manager if applicable

### Rule 5 — Protect authorization and audit
Any mutation in:
- watchlist
- alert
- saved screener
- workspace preset

must be checked for:
- authorization
- audit/history side effects
- test coverage

### Rule 6 — Use backend as source of truth
Heavy analytics, rule execution, screener execution, watchlist generation, and permission decisions belong in backend.  
Frontend should not reimplement business logic beyond rendering and local interaction.

---

## 18. Suggested mental model for a coding agent

Think of the repo in these layers:

### Layer 1 — Platform/runtime
- Spring Boot backend
- React/Vite frontend
- Tauri desktop wrapper

### Layer 2 — Shared infrastructure
- exchange schema resolution
- SQL fragment builder
- API error handling
- desktop bridge
- router + app shell
- workspace store

### Layer 3 — Core analysis domains
- dashboard
- instruments
- charts
- screener

### Layer 4 — User productivity domains
- saved screeners
- workspace presets
- watchlists
- alerts
- sharing/tagging
- rule generation

### Layer 5 — Control/audit/governance
- audit/history
- authz / role-aware access
- admin jobs
- rule lab

---

## 19. Recommended order for a coding agent fixing issues

If asked to “fix build issues” or “stabilize repo”, the best order is:

1. remove duplicate suffixed files
2. compile backend and fix:
   - broken interfaces
   - service/repository method mismatches
   - DTO drift
3. compile frontend and fix:
   - broken imports
   - wrong hook exports
   - route/page reference mismatches
4. run backend tests
5. run frontend tests
6. only then add new features

---

## 20. Recommended order for adding new features

### If backend-heavy feature
1. DTO
2. repository interface
3. repository impl
4. service interface
5. service impl
6. controller
7. integration test
8. frontend types/hooks/pages

### If frontend-heavy feature
1. route/page
2. types
3. hook
4. state store
5. shared component
6. tests
7. optional backend follow-up if client work uncovers API gap

### If workspace/chart feature
1. `workspace.store.ts`
2. `SynchronizedChartManager.ts`
3. `ChartPane.tsx`
4. `DockingWorkspace.tsx`
5. `WorkspacePresetManagementPage.tsx`
6. tests

---

## 21. Concrete list of files a coding agent should inspect first

### Backend
- `backend/pom.xml`
- `backend/src/main/java/com/rathore/stockanalysis/StockAnalysisBackendApplication.java`
- `backend/src/main/java/com/rathore/stockanalysis/common/exchange/ExchangeSchemaRegistry.java`
- `backend/src/main/java/com/rathore/stockanalysis/common/sql/SqlFragmentBuilder.java`
- `backend/src/main/java/com/rathore/stockanalysis/dashboard/**`
- `backend/src/main/java/com/rathore/stockanalysis/instrument/**`
- `backend/src/main/java/com/rathore/stockanalysis/chart/**`
- `backend/src/main/java/com/rathore/stockanalysis/screener/**`
- `backend/src/main/java/com/rathore/stockanalysis/preference/**`
- `backend/src/main/java/com/rathore/stockanalysis/watchlist/**`
- `backend/src/main/java/com/rathore/stockanalysis/audit/**`
- `backend/src/main/java/com/rathore/stockanalysis/authz/**`
- `backend/src/test/java/com/rathore/stockanalysis/support/PostgresIntegrationTestSupport.java`

### Frontend
- `frontend/package.json`
- `frontend/src/main.tsx`
- `frontend/src/routes/App.tsx`
- `frontend/src/app-shell/AppShell.tsx`
- `frontend/src/stores/workspace.store.ts`
- `frontend/src/chart-workbench/SynchronizedChartManager.ts`
- `frontend/src/workspace-layout/DockingWorkspace.tsx`
- `frontend/src/screener/ScreenerPage.tsx`
- `frontend/src/watchlists/**`
- `frontend/src/alerts/**`
- `frontend/src/hooks/api/**`
- `frontend/src/types/**`
- `frontend/src-tauri/**`

---

## 22. Build and validation sequence a coding agent should assume

### Backend
```bash
cd backend
mvn clean test
mvn spring-boot:run
```

### Frontend
```bash
cd frontend
npm install
npm run test
npm run build
npm run dev
```

### Desktop
```bash
cd frontend
npm run tauri:dev
npm run tauri:build
```

---

## 23. Deliverable expectations for future coding-agent tasks

When a coding agent is asked to implement or fix something in this project, it should ideally return:

1. the exact files changed
2. why those files were chosen
3. any DB/API compatibility notes
4. tests added or updated
5. any migration/setup steps required
6. any known unresolved risks after the change

---

## 24. Final practical guidance

If a coding agent is uncertain where to put a new feature, use this default decision tree:

- new backend endpoint or persistence → backend domain package
- new frontend page or flow → `frontend/src/...`
- new shared frontend state → `frontend/src/stores/...`
- new backend permission logic → `authz`
- new history/timeline logic → `audit`
- new saved-user-preference flow → `preference`
- new watchlist/alert operational flow → `watchlist`
- new chart/workspace behavior → `chart-workbench` + `workspace-layout` + `workspace.store`

The biggest practical trap in this repo is **editing the wrong duplicate file or extending a partially merged interface/service pair**.  
The safest approach is to start from the canonical paths in this document and verify imports before changing anything.

---
## 25. Current status summary

This project is **architecturally rich but operationally merge-heavy**.

It already contains:
- a serious backend API surface
- a real frontend workstation shell
- watchlist/alert/screener/preset/sharing domains
- audit and authorization scaffolding
- Tauri scaffolding
- CI/dev scripts
- backend repository integration tests

But it should still be treated as:
- **stabilize-first**
- **compile-verify after every patch**
- **clean duplicates continuously**
- **prefer canonical paths**
