import WatchlistTimelinePage from '../watchlists/WatchlistTimelinePage';
import AlertTimelinePage from '../alerts/AlertTimelinePage';
import { Navigate, Route, Routes } from 'react-router-dom';
import AppShell from '../app-shell/AppShell';
import DockingWorkspace from '../workspace-layout/DockingWorkspace';
import WorkspacePresetManagementPage from '../workspace-layout/WorkspacePresetManagementPage';
import DashboardPage from '../dashboard/DashboardPage';
import InstrumentsPage from '../instruments/InstrumentsPage';
import InstrumentSummaryPage from '../instruments/InstrumentSummaryPage';
import ScreenerPage from '../screener/ScreenerPage';
import WatchlistsPage from '../watchlists/WatchlistsPage';
import WatchlistDetailPage from '../watchlists/WatchlistDetailPage';
import AlertsPage from '../alerts/AlertsPage';
import AlertDetailPage from '../alerts/AlertDetailPage';

function Placeholder({ title }: { title: string }) {
  return <div style={{ padding: 20 }}><h1>{title}</h1><p>Starter module scaffold.</p></div>;
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<AppShell />}>
        <Route index element={<DashboardPage />} />
        <Route path="instruments" element={<InstrumentsPage />} />
        <Route path="instruments/:instrumentId/summary" element={<InstrumentSummaryPage />} />
        <Route path="screener" element={<ScreenerPage />} />
        <Route path="workspace" element={<DockingWorkspace />} />
        <Route path="workspace/presets" element={<WorkspacePresetManagementPage />} />
        <Route path="watchlists" element={<WatchlistsPage />} />
        <Route path="watchlists/:watchlistId" element={<WatchlistDetailPage />} />
        <Route path="alerts" element={<AlertsPage />} />
        <Route path="alerts/:alertRuleId" element={<AlertDetailPage />} />
        <Route path="rule-lab" element={<Placeholder title="Rule Lab" />} />
        <Route path="snapshot-inspector" element={<Placeholder title="Snapshot Inspector" />} />
        <Route path="admin" element={<Placeholder title="Admin Control Plane" />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Route>
    </Routes>
  );
}
