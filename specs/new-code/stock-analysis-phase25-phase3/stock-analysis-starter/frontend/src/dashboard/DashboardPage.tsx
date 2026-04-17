import { Link } from 'react-router-dom';
import { useDashboardOverviewQuery } from '../hooks/api/useDashboardOverviewQuery';
import { useDataCoverageQuery } from '../hooks/api/useDataCoverageQuery';
import { useWorkspaceStore } from '../stores/workspace.store';

function MetricCard({ label, value, to }: { label: string; value?: number | string | null; to?: string }) {
  const body = (
    <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
      <div style={{ opacity: 0.75, marginBottom: 8 }}>{label}</div>
      <div style={{ fontSize: 28, fontWeight: 700 }}>{value ?? '—'}</div>
    </div>
  );
  return to ? <Link to={to}>{body}</Link> : body;
}

export default function DashboardPage() {
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const overview = useDashboardOverviewQuery({ exchangeCode, tradeDate, timeframe: 'day' });
  const coverage = useDataCoverageQuery(exchangeCode);

  if (overview.isLoading || coverage.isLoading) return <div style={{ padding: 20 }}>Loading dashboard…</div>;
  if (overview.error || coverage.error) return <div style={{ padding: 20 }}>Failed to load dashboard.</div>;

  const o = overview.data!;
  const c = coverage.data!;

  return (
    <div style={{ padding: 20, display: 'grid', gap: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <h1 style={{ margin: 0 }}>Analytics Dashboard</h1>
          <div style={{ opacity: 0.75 }}>Exchange {exchangeCode} · Trade Date {tradeDate}</div>
        </div>
        <Link to="/instruments" style={{ padding: '10px 14px', background: '#2563eb', borderRadius: 8 }}>Open Instruments</Link>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5, minmax(0, 1fr))', gap: 12 }}>
        <MetricCard label="Total Instruments" value={o.totalActiveInstruments} />
        <MetricCard label="With Data" value={o.instrumentsWithData} to="/instruments" />
        <MetricCard label="Uptrend" value={o.uptrendCount} to="/instruments?trend=UPTREND" />
        <MetricCard label="Downtrend" value={o.downtrendCount} to="/instruments?trend=DOWNTREND" />
        <MetricCard label="Sideways" value={o.sidewaysCount} to="/instruments?trend=SIDEWAYS" />
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
        <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
          <h3 style={{ marginTop: 0 }}>Timeframe Coverage</h3>
          <div>Hour: {c.byTimeframeAvailability.hour}</div>
          <div>Day: {c.byTimeframeAvailability.day}</div>
          <div>Week: {c.byTimeframeAvailability.week}</div>
        </div>
        <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
          <h3 style={{ marginTop: 0 }}>Bootstrap Status</h3>
          {c.byBootstrapStatus.map((item) => (
            <div key={item.status} style={{ display: 'flex', justifyContent: 'space-between' }}>
              <span>{item.status}</span><strong>{item.count}</strong>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
