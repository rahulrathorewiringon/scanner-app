import { Navigate, Route, Routes } from 'react-router-dom';
import AppShell from '../app-shell/AppShell';
import DockingWorkspace from '../workspace-layout/DockingWorkspace';
import DashboardPage from '../dashboard/DashboardPage';
import InstrumentsPage from '../instruments/InstrumentsPage';

function Placeholder({ title }: { title: string }) {
  return <div style={{ padding: 20 }}><h1>{title}</h1><p>Starter module scaffold.</p></div>;
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<AppShell />}>
        <Route index element={<DashboardPage />} />
        <Route path="instruments" element={<InstrumentsPage />} />
        <Route path="workspace" element={<DockingWorkspace />} />
        <Route path="watchlists" element={<Placeholder title="Watchlists" />} />
        <Route path="alerts" element={<Placeholder title="Alerts" />} />
        <Route path="rule-lab" element={<Placeholder title="Rule Lab" />} />
        <Route path="snapshot-inspector" element={<Placeholder title="Snapshot Inspector" />} />
        <Route path="admin" element={<Placeholder title="Admin Control Plane" />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Route>
    </Routes>
  );
}
