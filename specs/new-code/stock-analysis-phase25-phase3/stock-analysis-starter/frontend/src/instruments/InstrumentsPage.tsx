import { useSearchParams, Link } from 'react-router-dom';
import { useInstrumentSearchQuery } from '../hooks/api/useInstrumentSearchQuery';
import { useInstrumentSummaryQuery } from '../hooks/api/useInstrumentSummaryQuery';
import { useWorkspaceStore } from '../stores/workspace.store';

export default function InstrumentsPage() {
  const [searchParams] = useSearchParams();
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const activeInstrumentId = useWorkspaceStore((s) => s.activeInstrumentId);
  const setActiveInstrumentId = useWorkspaceStore((s) => s.setActiveInstrumentId);
  const symbolQuery = useWorkspaceStore((s) => s.symbolQuery);
  const setSymbolQuery = useWorkspaceStore((s) => s.setSymbolQuery);
  const trendFilter = (searchParams.get('trend') as 'ALL' | 'UPTREND' | 'DOWNTREND' | 'SIDEWAYS' | null) ?? useWorkspaceStore.getState().trendFilter;

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
    <div style={{ display: 'grid', gridTemplateColumns: '1.3fr 0.9fr', minHeight: '100%' }}>
      <div style={{ padding: 20, borderRight: '1px solid #243043' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <div>
            <h1 style={{ margin: 0 }}>Instruments</h1>
            <div style={{ opacity: 0.75 }}>Trend filter: {trendFilter}</div>
          </div>
          <input value={symbolQuery} onChange={(e) => setSymbolQuery(e.target.value)} placeholder="Search symbol" style={{ padding: 8, width: 220 }} />
        </div>

        {search.isLoading ? <div>Loading instruments…</div> : search.error ? <div>Failed to load instruments.</div> : (
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr>
                {['Symbol', 'Type', 'Sector', 'Trend', 'Candle', 'Pivot', 'SMA', 'Actions'].map((h) => (
                  <th key={h} style={{ textAlign: 'left', padding: '10px 8px', borderBottom: '1px solid #243043' }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {search.data?.rows.map((row) => (
                <tr key={row.instrumentId} onClick={() => setActiveInstrumentId(row.instrumentId)} style={{ cursor: 'pointer' }}>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.symbol}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.instrumentType}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.sector ?? '—'}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.trendState ?? '—'}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.currentCandlePattern ?? '—'}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.latestPivotType ?? '—'}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>{row.smaStructure ?? '—'}</td>
                  <td style={{ padding: '10px 8px', borderBottom: '1px solid #1f2937' }}>
                    <Link to="/workspace" onClick={(e) => e.stopPropagation()} style={{ color: '#60a5fa' }}>Charts</Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      <div style={{ padding: 20 }}>
        <h2 style={{ marginTop: 0 }}>Instrument Summary</h2>
        {summary.isLoading ? <div>Loading summary…</div> : summary.error ? <div>Failed to load summary.</div> : summary.data && (
          <div style={{ display: 'grid', gap: 12 }}>
            <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
              <div style={{ fontSize: 22, fontWeight: 700 }}>{summary.data.identity.symbol}</div>
              <div>{summary.data.identity.instrumentType} · {summary.data.identity.exchangeCode}</div>
              <div>{summary.data.identity.sector ?? '—'} / {summary.data.identity.industry ?? '—'}</div>
            </div>
            <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
              <div><strong>Trend:</strong> {summary.data.trend.state ?? '—'}</div>
              <div><strong>Timeframes:</strong> {summary.data.dataAvailability.chartTimeframesAvailable.join(', ')}</div>
              <div><strong>Bootstrap:</strong> {summary.data.dataAvailability.bootstrapStatus}</div>
            </div>
            <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
              <div><strong>Daily SMA:</strong> {summary.data.smaStructure?.day ?? '—'}</div>
              <div><strong>Pivot:</strong> {summary.data.pivots?.latestPivotType ?? '—'}</div>
              <div><strong>Trend Pivot:</strong> {summary.data.pivots?.latestTrendPivotType ?? '—'}</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
