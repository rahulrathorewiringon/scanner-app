import { Link } from 'react-router-dom';
import { useDashboardOverviewQuery } from '../hooks/api/useDashboardOverviewQuery';
import { useDataCoverageQuery } from '../hooks/api/useDataCoverageQuery';
import { useInstrumentSearchQuery } from '../hooks/api/useInstrumentSearchQuery';
import { useWorkspaceStore } from '../stores/workspace.store';

function MetricCard({ label, value, subtext, to }: { label: string; value?: number | string | null; subtext?: string; to?: string }) {
  const body = (
    <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827', height:'100%' }}>
      <div style={{ opacity: 0.75, marginBottom: 8 }}>{label}</div>
      <div style={{ fontSize: 28, fontWeight: 700 }}>{value ?? '—'}</div>
      {subtext ? <div style={{ marginTop: 8, fontSize: 12, opacity: 0.7 }}>{subtext}</div> : null}
    </div>
  );
  return to ? <Link to={to}>{body}</Link> : body;
}

export default function DashboardPage() {
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const setActiveInstrumentId = useWorkspaceStore((s) => s.setActiveInstrumentId);
  const overview = useDashboardOverviewQuery({ exchangeCode, tradeDate, timeframe: 'day' });
  const coverage = useDataCoverageQuery(exchangeCode);
  const preview = useInstrumentSearchQuery({
    exchangeCode,
    tradeDate,
    trendFilter: 'ALL',
    pageIndex: 0,
    pageSize: 8,
    sort: [{ field: 'updated_at', direction: 'desc' }],
  });

  if (overview.isLoading || coverage.isLoading || preview.isLoading) return <div style={{ padding: 20 }}>Loading dashboard…</div>;
  if (overview.error || coverage.error || preview.error) return <div style={{ padding: 20 }}>Failed to load dashboard.</div>;

  const o = overview.data!;
  const c = coverage.data!;

  return (
    <div style={{ padding: 20, display: 'grid', gap: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <h1 style={{ margin: 0 }}>Analytics Dashboard</h1>
          <div style={{ opacity: 0.75 }}>Exchange {exchangeCode} · Trade Date {tradeDate}</div>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <Link to="/screener" style={buttonPrimary}>Open Screener</Link>
          <Link to="/instruments" style={buttonSecondary}>Open Instruments</Link>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(6, minmax(0, 1fr))', gap: 12 }}>
        <MetricCard label="Total Instruments" value={o.totalActiveInstruments} subtext={`Latest chart date ${o.latestChartToDate ?? '—'}`} />
        <MetricCard label="With Data" value={o.instrumentsWithData} to="/instruments" />
        <MetricCard label="Uptrend" value={o.uptrendCount} to="/instruments?trend=UPTREND" />
        <MetricCard label="Downtrend" value={o.downtrendCount} to="/instruments?trend=DOWNTREND" />
        <MetricCard label="Sideways" value={o.sidewaysCount} to="/instruments?trend=SIDEWAYS" />
        <MetricCard label="Rebuild Required" value={c.rebuildRequiredCount} subtext={`Stale ${c.staleCount}`} />
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1.2fr', gap: 12 }}>
        <Panel title="Timeframe Coverage">
          <CoverageRow label="Hour" value={c.byTimeframeAvailability.hour} total={c.totalActiveInstruments} />
          <CoverageRow label="Day" value={c.byTimeframeAvailability.day} total={c.totalActiveInstruments} />
          <CoverageRow label="Week" value={c.byTimeframeAvailability.week} total={c.totalActiveInstruments} />
        </Panel>

        <Panel title="Bootstrap Status">
          {c.byBootstrapStatus.map((item) => (
            <div key={item.status} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
              <span>{item.status}</span><strong>{item.count}</strong>
            </div>
          ))}
        </Panel>

        <Panel title="Recent Instrument Snapshot">
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr><th style={th}>Symbol</th><th style={th}>Trend</th><th style={th}>Pivot</th><th style={th}>Action</th></tr>
            </thead>
            <tbody>
              {preview.data?.rows.map((row) => (
                <tr key={row.instrumentId}>
                  <td style={td}>{row.symbol}</td>
                  <td style={td}>{row.trendState ?? '—'}</td>
                  <td style={td}>{row.latestPivotType ?? '—'}</td>
                  <td style={td}>
                    <Link to="/workspace" onClick={() => setActiveInstrumentId(row.instrumentId)} style={{ color: '#60a5fa' }}>Open</Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Panel>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
        <Panel title="Trend Distribution">
          {[
            ['UPTREND', o.uptrendCount],
            ['SIDEWAYS', o.sidewaysCount],
            ['DOWNTREND', o.downtrendCount],
          ].map(([label, count]) => (
            <CoverageRow key={label} label={label} value={Number(count)} total={o.instrumentsWithData || 1} />
          ))}
        </Panel>

        <Panel title="Chart Data Status">
          {c.byChartDataStatus.map((item) => (
            <div key={item.status} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
              <span>{item.status}</span><strong>{item.count}</strong>
            </div>
          ))}
        </Panel>
      </div>
    </div>
  );
}

const buttonPrimary: React.CSSProperties = { padding: '10px 14px', background: '#2563eb', borderRadius: 8 };
const buttonSecondary: React.CSSProperties = { padding: '10px 14px', background: '#1f2937', borderRadius: 8 };
const th: React.CSSProperties = { textAlign:'left', padding:'6px 4px', borderBottom:'1px solid #243043' };
const td: React.CSSProperties = { padding:'8px 4px', borderBottom:'1px solid #1f2937' };

function Panel({ title, children }: React.PropsWithChildren<{ title: string }>) {
  return (
    <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
      <h3 style={{ marginTop: 0 }}>{title}</h3>
      {children}
    </div>
  );
}
function CoverageRow({ label, value, total }: { label: string; value: number; total: number }) {
  const pct = total > 0 ? Math.round((value / total) * 100) : 0;
  return (
    <div style={{ display:'grid', gap:6, marginBottom:10 }}>
      <div style={{ display:'flex', justifyContent:'space-between' }}>
        <span>{label}</span><strong>{value}</strong>
      </div>
      <div style={{ background:'#1f2937', borderRadius:999, height:8 }}>
        <div style={{ width:`${pct}%`, background:'#2563eb', height:8, borderRadius:999 }} />
      </div>
    </div>
  );
}
