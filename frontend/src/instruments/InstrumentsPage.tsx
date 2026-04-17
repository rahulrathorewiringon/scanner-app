import { useSearchParams, Link } from 'react-router-dom';
import { useInstrumentSearchQuery } from '../hooks/api/useInstrumentSearchQuery';
import { useInstrumentSummaryQuery } from '../hooks/api/useInstrumentSummaryQuery';
import { useWorkspaceStore } from '../stores/workspace.store';
import InstrumentSummaryPanel from './InstrumentSummaryPanel';

export default function InstrumentsPage() {
  const [searchParams] = useSearchParams();
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const activeInstrumentId = useWorkspaceStore((s) => s.activeInstrumentId);
  const setActiveInstrumentId = useWorkspaceStore((s) => s.setActiveInstrumentId);
  const symbolQuery = useWorkspaceStore((s) => s.symbolQuery);
  const setSymbolQuery = useWorkspaceStore((s) => s.setSymbolQuery);
  const trendFilter = (searchParams.get('trend') as 'ALL' | 'UPTREND' | 'DOWNTREND' | 'SIDEWAYS' | null) ?? 'ALL';

  const search = useInstrumentSearchQuery({
    exchangeCode,
    tradeDate,
    trendFilter,
    symbolQuery,
    pageIndex: 0,
    pageSize: 50,
    sort: [{ field: 'symbol', direction: 'asc' }],
  });

  const summary = useInstrumentSummaryQuery({ exchangeCode, tradeDate, instrumentId: activeInstrumentId });

  return (
    <div style={{ display: 'grid', gridTemplateColumns: '1.35fr 0.95fr', minHeight: '100%' }}>
      <div style={{ padding: 20, borderRight: '1px solid #243043' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <div>
            <h1 style={{ margin: 0 }}>Instrument Universe</h1>
            <div style={{ opacity: 0.75 }}>Trend filter: {trendFilter}</div>
          </div>
          <input value={symbolQuery} onChange={(e) => setSymbolQuery(e.target.value)} placeholder="Search symbol" style={{ padding: 8, width: 220 }} />
        </div>

        {search.isLoading ? <div>Loading instruments…</div> : search.error ? <div>Failed to load instruments.</div> : (
          <>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, minmax(0,1fr))', gap: 12, marginBottom: 16 }}>
              <SummaryStat label="Rows" value={search.data?.totalRows ?? 0} />
              <SummaryStat label="Exchange" value={exchangeCode} />
              <SummaryStat label="Date" value={tradeDate} />
              <SummaryStat label="Active" value={activeInstrumentId} />
            </div>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr>
                  {['Symbol', 'Type', 'Sector', 'Trend', 'Candle', 'Pivot', 'SMA', 'TF', 'Actions'].map((h) => (
                    <th key={h} style={{ textAlign: 'left', padding: '10px 8px', borderBottom: '1px solid #243043' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {search.data?.rows.map((row) => (
                  <tr key={row.instrumentId} onClick={() => setActiveInstrumentId(row.instrumentId)} style={{ cursor: 'pointer', background: row.instrumentId === activeInstrumentId ? '#132038' : 'transparent' }}>
                    <td style={cell}>{row.symbol}</td>
                    <td style={cell}>{row.instrumentType}</td>
                    <td style={cell}>{row.sector ?? '—'}</td>
                    <td style={cell}>{row.trendState ?? '—'}</td>
                    <td style={cell}>{row.currentCandlePattern ?? '—'}</td>
                    <td style={cell}>{row.latestPivotType ?? '—'}</td>
                    <td style={cell}>{row.smaStructure ?? '—'}</td>
                    <td style={cell}>{(row.chartTimeframesAvailable ?? []).join(', ')}</td>
                    <td style={cell}>
                      <div style={{ display: 'flex', gap: 10 }}>
                        <Link to={`/instruments/${row.instrumentId}/summary`} onClick={(e) => e.stopPropagation()} style={{ color: '#60a5fa' }}>Summary</Link>
                        <Link to="/workspace" onClick={(e) => { e.stopPropagation(); setActiveInstrumentId(row.instrumentId); }} style={{ color: '#60a5fa' }}>Charts</Link>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        )}
      </div>

      <div style={{ padding: 20 }}>
        <h2 style={{ marginTop: 0 }}>Instrument Summary</h2>
        {summary.isLoading ? <div>Loading summary…</div> : summary.error || !summary.data ? <div>Failed to load summary.</div> : <InstrumentSummaryPanel summary={summary.data} />}
      </div>
    </div>
  );
}

const cell: React.CSSProperties = { padding: '10px 8px', borderBottom: '1px solid #1f2937', verticalAlign: 'top' };

function SummaryStat({ label, value }: { label: string; value: string | number }) {
  return (
    <div style={{ border: '1px solid #243043', borderRadius: 8, background: '#111827', padding: 12 }}>
      <div style={{ opacity: 0.75, fontSize: 12 }}>{label}</div>
      <div style={{ fontSize: 18, fontWeight: 700 }}>{value}</div>
    </div>
  );
}
