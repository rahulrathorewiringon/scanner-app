import { Link, Outlet } from 'react-router-dom';

const navItems = [
  { to: '/', label: 'Dashboard' },
  { to: '/instruments', label: 'Instruments' },
  { to: '/workspace', label: 'Workspace' },
  { to: '/watchlists', label: 'Watchlists' },
  { to: '/alerts', label: 'Alerts' },
  { to: '/rule-lab', label: 'Rule Lab' },
  { to: '/snapshot-inspector', label: 'Snapshot Inspector' },
  { to: '/admin', label: 'Admin' },
];

export default function AppShell() {
  return (
    <div style={{ display: 'grid', gridTemplateColumns: '240px 1fr', height: '100%' }}>
      <aside style={{ borderRight: '1px solid #243043', padding: 16 }}>
        <h2 style={{ marginTop: 0 }}>Stock Analysis</h2>
        <nav style={{ display: 'grid', gap: 10 }}>
          {navItems.map((item) => (
            <Link key={item.to} to={item.to}>{item.label}</Link>
          ))}
        </nav>
      </aside>
      <main style={{ minWidth: 0 }}>
        <Outlet />
      </main>
    </div>
  );
}
