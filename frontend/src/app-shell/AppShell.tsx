import { Link, Outlet, useLocation } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';

const navItems = [
  { to: '/', label: 'Dashboard' },
  { to: '/instruments', label: 'Instruments' },
  { to: '/screener', label: 'Screener' },
  { to: '/workspace', label: 'Workspace' },
  { to: '/workspace/presets', label: 'Workspace Presets' },
  { to: '/watchlists', label: 'Watchlists' },
  { to: '/alerts', label: 'Alerts' },
  { to: '/rule-lab', label: 'Rule Lab' },
  { to: '/snapshot-inspector', label: 'Snapshot Inspector' },
  { to: '/admin', label: 'Admin' },
];

export default function AppShell() {
  const location = useLocation();
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const setExchangeCode = useWorkspaceStore((s) => s.setExchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const setTradeDate = useWorkspaceStore((s) => s.setTradeDate);
  const userId = useWorkspaceStore((s) => s.userId);
  const setUserId = useWorkspaceStore((s) => s.setUserId);

  return (
    <div style={{ display: 'grid', gridTemplateColumns: '240px 1fr', height: '100%' }}>
      <aside style={{ borderRight: '1px solid #243043', padding: 16, background: '#0f172a' }}>
        <h2 style={{ marginTop: 0 }}>Stock Analysis</h2>
        <nav style={{ display: 'grid', gap: 10, marginBottom: 20 }}>
          {navItems.map((item) => {
            const active = location.pathname === item.to || (item.to !== '/' && location.pathname.startsWith(item.to));
            return (
              <Link key={item.to} to={item.to} style={{ padding: '8px 10px', borderRadius: 8, background: active ? '#1d4ed8' : 'transparent', color: '#e5e7eb', textDecoration: 'none' }}>
                {item.label}
              </Link>
            );
          })}
        </nav>
        <div style={{ display: 'grid', gap: 10 }}>
          <label style={{ display: 'grid', gap: 6 }}><span style={{ fontSize: 12, opacity: 0.75 }}>User</span><input value={userId} onChange={(e) => setUserId(e.target.value)} style={{ padding: 8 }} /></label>
          <label style={{ display: 'grid', gap: 6 }}><span style={{ fontSize: 12, opacity: 0.75 }}>Exchange</span><select value={exchangeCode} onChange={(e) => setExchangeCode(e.target.value as any)} style={{ padding: 8 }}><option value="NSE">NSE</option><option value="BSE">BSE</option><option value="NFO">NFO</option><option value="BFO">BFO</option><option value="MCX">MCX</option></select></label>
          <label style={{ display: 'grid', gap: 6 }}><span style={{ fontSize: 12, opacity: 0.75 }}>Trade Date</span><input type="date" value={tradeDate} onChange={(e) => setTradeDate(e.target.value)} style={{ padding: 8 }} /></label>
        </div>
      </aside>
      <main style={{ minWidth: 0, background: '#0b1220' }}><Outlet /></main>
    </div>
  );
}
