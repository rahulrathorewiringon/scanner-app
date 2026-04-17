# Stock Analysis Workstation – Locked UI Architecture & End-to-End Development Specification

## 1. Locked technology decisions

These are fixed architectural decisions for the workstation UI and must be treated as non-negotiable unless product direction changes deliberately.

### Frontend
- React
- TypeScript
- FlexLayout for desktop-style docking workspace
- Lightweight Charts for all chart rendering
- Zustand for client state
- TanStack Query for server state
- Tailwind CSS + shadcn/ui for UI primitives

### Desktop packaging
- Tauri as the desktop shell
- The React app must still run in browser mode for development and internal admin use
- Initial native integration is intentionally minimal:
  - file export
  - local config storage
  - window management
  - optional notifications

### Backend
- Spring Boot / Java
- PostgreSQL
- Redis
- In-memory aggregation / rule evaluation stays in backend
- Frontend remains a thin rendering + orchestration layer

## 2. Core architectural rule

No business logic moves into the frontend.

The frontend may:
- request normalized snapshots
- orchestrate workspace state
- render synchronized charts
- manage docking, watchlists, filters, and drawer state

The frontend may not:
- recompute pivots
- recompute SMA relationships
- evaluate screening rules against raw candles in browser
- duplicate backend trend or alert logic

## 3. Two-layer UI architecture

The UI has two distinct layers.

### Layer 1: Fixed application shell
This layer provides the stable control-plane modules:
- Watchlists
- Alerts
- Rule Testing
- Snapshot Inspector
- Universe Monitor
- Admin Jobs
- Settings
- Workspace

### Layer 2: Dockable workspace
Inside the **Workspace** module, use FlexLayout to provide:
- docked chart tabs
- multi-timeframe pane sets
- symbol context panels
- rule-debug panels
- alert timeline panels
- snapshot inspector panels

This keeps the overall application stable while allowing the chart workspace to behave like a desktop trading terminal.

## 4. Primary routes and modules

```text
/app
  /workspace
  /watchlists
  /alerts
  /rule-lab
  /snapshot-inspector
  /universe-monitor
  /admin/jobs
  /settings
```

### Within Workspace
The workspace itself hosts docked content such as:
- Dashboard view
- Instruments grid
- Screener view
- Instrument summary view
- Multi-timeframe chart set
- Pivot chart view
- Rule explanation view
- Alert timeline view

## 5. Frontend module structure

```text
src/
  app-shell/
  workspace-layout/
  chart-workbench/
  watchlist-console/
  alert-console/
  rule-lab/
  snapshot-inspector/
  admin-control-plane/
  shared/
  hooks/api/
  stores/
  types/
```

### Required submodules

#### `app-shell`
- `AppShell.tsx`
- `Sidebar.tsx`
- `Topbar.tsx`
- `ExchangeSelector.tsx`
- `TradeDateSelector.tsx`
- `GlobalTickerSearch.tsx`
- `NotificationHost.tsx`

#### `workspace-layout`
- `WorkspacePage.tsx`
- `DockingWorkspace.tsx`
- `flexlayout-model.ts`
- `WorkspaceToolbar.tsx`
- `WorkspaceTabFactory.tsx`
- `SavedWorkspaceLayoutManager.ts`

#### `chart-workbench`
- `MultiTimeframeChartSet.tsx`
- `ChartPane.tsx`
- `SynchronizedChartManager.ts`
- `ChartSeriesAdapter.ts`
- `PivotOverlayLayer.tsx`
- `SupportResistanceOverlayLayer.tsx`
- `SymbolContextPanel.tsx`
- `RuleExplanationPanel.tsx`
- `AlertTimelinePanel.tsx`

#### `watchlist-console`
- `WatchlistPage.tsx`
- `WatchlistTable.tsx`
- `WatchlistSidebar.tsx`

#### `alert-console`
- `AlertsPage.tsx`
- `AlertRuleTable.tsx`
- `AlertTimelinePanel.tsx`

#### `rule-lab`
- `RuleLabPage.tsx`
- `RuleTestForm.tsx`
- `RuleEvaluationResultPanel.tsx`

#### `snapshot-inspector`
- `SnapshotInspectorPage.tsx`
- `SnapshotSummaryPanel.tsx`
- `SnapshotRawJsonPanel.tsx`

#### `admin-control-plane`
- `AdminJobsPage.tsx`
- `JobTriggerPanel.tsx`
- `JobExecutionHistoryTable.tsx`

## 6. Workspace component hierarchy

```text
WorkspacePage
└─ DockingWorkspace
   ├─ WorkspaceToolbar
   ├─ FlexLayoutHost
   │  ├─ DashboardTab
   │  ├─ InstrumentsTab
   │  ├─ ScreenerTab
   │  ├─ InstrumentSummaryTab
   │  ├─ MultiTimeframeChartSet
   │  ├─ PivotChartTab
   │  ├─ RuleExplanationPanel
   │  ├─ AlertTimelinePanel
   │  └─ SnapshotInspectorTab
   └─ WorkspaceStatusBar
```

## 7. Chart workbench design

### 7.1 Locked charting choice
All charts use **Lightweight Charts**. No alternate charting library should be introduced for the workstation chart surface.

### 7.2 Synchronized-chart manager
All multi-chart coordination goes through a single manager abstraction.

`SynchronizedChartManager` owns:
- active symbol
- active exchange
- visible range sync
- crosshair sync
- indicator overlays
- pivot annotations
- support/resistance markers
- selected pivot state

### 7.3 Required chart set
`MultiTimeframeChartSet` must support:
- Weekly pane
- Daily pane
- Hourly pane

Each pane must be independently renderable, but coordinated by `SynchronizedChartManager`.

### 7.4 Chart pane responsibilities
`ChartPane` is a thin rendering surface that:
- receives normalized candles and overlays from backend
- registers itself with the sync manager
- publishes visible-range and crosshair events
- renders pivots/SR overlays

## 8. Fixed backend contract philosophy

Frontend talks only to normalized control-plane APIs.

Required API families:
- fetch snapshot
- fetch watchlist candidates
- fetch alert state
- trigger population/alert jobs
- evaluate saved rule
- inspect cooldown/dedup state
- fetch instrument universe
- fetch summary snapshot
- fetch chart payloads
- run screener

## 9. Backend API specification

### 9.1 Dashboard / overview
- `GET /api/analytics/dashboard-overview`
- `GET /api/analytics/data-coverage`

### 9.2 Instruments / snapshots
- `POST /api/analytics/instruments/search`
- `GET /api/instruments/{instrumentId}/summary`
- `GET /api/instruments/{instrumentId}/snapshot`

### 9.3 Charts
- `GET /api/instruments/{instrumentId}/charts`
- `GET /api/charts/{instrumentId}/pivot-sequence`
- `GET /api/charts/{instrumentId}/support-resistance`

### 9.4 Screener
- `GET /api/screener/filter-metadata`
- `POST /api/screener/count`
- `POST /api/screener/run`
- `POST /api/screener/export`

### 9.5 Watchlists / alerts / rules
- `GET /api/watchlists`
- `GET /api/watchlists/{watchlistId}/items`
- `GET /api/alerts/rules`
- `GET /api/alerts/events`
- `POST /api/rules/evaluate`
- `GET /api/alerts/cooldown-state`

### 9.6 Admin jobs
- `POST /api/admin/jobs/watchlist-population/run`
- `POST /api/admin/jobs/alert-cycle/run`
- `GET /api/admin/jobs/executions`

## 10. Java service design

```text
common/
  exchange/
  web/
  paging/
workspace/
  controller/
  dto/
  service/
dashboard/
  controller/
  dto/
  service/
  repository/
instrument/
  controller/
  dto/
  service/
  repository/
chart/
  controller/
  dto/
  service/
  repository/
screener/
  controller/
  dto/
  service/
  repository/
watchlist/
  controller/
  dto/
  service/
alert/
  controller/
  dto/
  service/
rulelab/
  controller/
  dto/
  service/
adminjobs/
  controller/
  dto/
  service/
```

### Key service interfaces
- `DashboardService`
- `InstrumentService`
- `ChartService`
- `ScreenerService`
- `WatchlistService`
- `AlertService`
- `RuleLabService`
- `AdminJobsService`

## 11. Frontend TS contract

### Core enums
```ts
export type ExchangeCode = "NSE" | "BSE" | "NFO" | "BFO" | "MCX";
export type Timeframe = "hour" | "day" | "week";
export type TrendState = "UPTREND" | "DOWNTREND" | "SIDEWAYS";
```

### Workspace tabs
```ts
export type WorkspaceTabKind =
  | "dashboard"
  | "instruments"
  | "screener"
  | "instrument-summary"
  | "multi-timeframe-chart"
  | "pivot-chart"
  | "rule-explanation"
  | "alert-timeline"
  | "snapshot-inspector";
```

### Chart workspace DTOs
```ts
export interface ChartContextDto {
  instrumentId: number;
  symbol: string;
  exchangeCode: ExchangeCode;
  selectedTimeframes: Timeframe[];
}

export interface ChartPaneStateDto {
  timeframe: Timeframe;
  visibleFrom?: string | null;
  visibleTo?: string | null;
  crosshairTime?: string | null;
  showSma: boolean;
  showPivots: boolean;
  showSupportResistance: boolean;
}
```

## 12. Zustand stores

### `workspace-layout.store.ts`
Holds:
- active workspace layout model
- current tab registry
- selected tab id
- saved layout ids

### `chart-workbench.store.ts`
Holds:
- active chart context
- pane state per timeframe
- selected pivot id
- sync toggles
- overlay toggles

### `watchlist-console.store.ts`
Holds:
- selectedWatchlistId
- selectedRows
- candidateFilterState

### `alert-console.store.ts`
Holds:
- activeAlertTab
- selectedRuleId
- selectedEventId

### `rule-lab.store.ts`
Holds:
- selectedRuleDefinition
- evaluationInput
- evaluationResult

### `snapshot-inspector.store.ts`
Holds:
- selectedInstrumentId
- selectedTradeDate
- selectedSnapshotKind

## 13. FlexLayout implementation requirements

- Workspace uses a single FlexLayout model as the source of truth
- Tab creation is done by a central `WorkspaceTabFactory`
- Layout JSON must be serializable and persisted
- A saved layout can be restored across sessions
- Do not embed business state directly in FlexLayout nodes; keep business state in Zustand stores and reference IDs from layout nodes

## 14. Tauri requirements

### Must support
- browser-first development mode
- desktop packaging with Tauri
- optional file export integration
- local workspace layout persistence
- native window title updates

### Must not do in first phase
- move business logic into Rust/Tauri sidecar
- create desktop-only routing
- fork the web app architecture for desktop

## 15. Complete file structure for coding agent

```text
src/
  app-shell/
    AppShell.tsx
    Sidebar.tsx
    Topbar.tsx
    ExchangeSelector.tsx
    TradeDateSelector.tsx
    GlobalTickerSearch.tsx

  workspace-layout/
    WorkspacePage.tsx
    DockingWorkspace.tsx
    WorkspaceToolbar.tsx
    WorkspaceTabFactory.tsx
    flexlayout-model.ts
    SavedWorkspaceLayoutManager.ts

  chart-workbench/
    MultiTimeframeChartSet.tsx
    ChartPane.tsx
    PivotChartPane.tsx
    SymbolContextPanel.tsx
    RuleExplanationPanel.tsx
    AlertTimelinePanel.tsx
    overlays/
      PivotOverlayLayer.tsx
      SupportResistanceOverlayLayer.tsx
    sync/
      SynchronizedChartManager.ts
      chart-sync.types.ts
      chart-sync.utils.ts
    adapters/
      ChartSeriesAdapter.ts
      LightweightChartsBridge.ts

  watchlist-console/
    WatchlistPage.tsx
    WatchlistSidebar.tsx
    WatchlistTable.tsx

  alert-console/
    AlertsPage.tsx
    AlertRuleTable.tsx
    AlertEventsTable.tsx

  rule-lab/
    RuleLabPage.tsx
    RuleTestForm.tsx
    RuleEvaluationResultPanel.tsx

  snapshot-inspector/
    SnapshotInspectorPage.tsx
    SnapshotSummaryPanel.tsx
    SnapshotRawJsonPanel.tsx

  admin-control-plane/
    AdminJobsPage.tsx
    JobTriggerPanel.tsx
    JobExecutionHistoryTable.tsx

  hooks/api/
    apiClient.ts
    useDashboardOverviewQuery.ts
    useInstrumentSearchQuery.ts
    useInstrumentSummaryQuery.ts
    useMultiTimeframeChartsQuery.ts
    useWatchlistsQuery.ts
    useAlertRulesQuery.ts
    useRuleEvaluationMutation.ts
    useAdminJobsHooks.ts

  stores/
    workspace-layout.store.ts
    chart-workbench.store.ts
    watchlist-console.store.ts
    alert-console.store.ts
    rule-lab.store.ts
    snapshot-inspector.store.ts

  types/
    common.types.ts
    workspace.types.ts
    chart.types.ts
    dashboard.types.ts
    instrument.types.ts
    screener.types.ts
    watchlist.types.ts
    alert.types.ts
    rule-lab.types.ts
    admin-jobs.types.ts
```

## 16. Testing specification

### Frontend unit
- FlexLayout model builder creates expected workspace tree
- `WorkspaceTabFactory` resolves correct tab component
- `SynchronizedChartManager` propagates visible-range and crosshair updates
- chart overlay toggles update all panes correctly
- browser mode works without Tauri APIs

### Frontend integration
- workspace loads default layout
- saved layout restores tabs
- opening instrument from universe table spawns summary + chart tabs
- multi-timeframe chart set stays synchronized when one pane scrolls
- rule evaluation panel renders backend result correctly

### Backend unit
- schema registry resolves exchange schemas correctly
- workspace/service DTO assemblers return normalized payloads
- rule evaluation service delegates to backend engine only
- admin jobs service triggers correct job commands

### Backend integration
- dashboard overview works against seeded instrument_master + bootstrap + snapshot tables
- instrument summary joins bootstrap, market_candle, feature, and pivot tables correctly
- charts endpoint returns candles + overlays for week/day/hour
- screener respects bootstrap data-availability prefilter
- rule evaluation and cooldown-state endpoints serialize correctly

## 17. Final locked implementation statement

Build the application as a **React workstation UI with a fixed shell and a FlexLayout-powered dockable workspace**, using **Lightweight Charts** for all chart rendering and **Tauri** for desktop packaging. Keep heavy analytics, rule execution, pivots, trend state, and screening logic in the backend. The frontend acts as a thin control plane that orchestrates layouts, tabs, chart synchronization, watchlists, alerts, and rule-inspection workflows through normalized APIs.
