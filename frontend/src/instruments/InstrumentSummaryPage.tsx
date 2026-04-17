import { Link, useParams } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useInstrumentSummaryQuery } from '../hooks/api/useInstrumentSummaryQuery';
import InstrumentSummaryPanel from './InstrumentSummaryPanel';

export default function InstrumentSummaryPage() {
  const { instrumentId } = useParams();
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const id = Number(instrumentId);
  const query = useInstrumentSummaryQuery({ exchangeCode, tradeDate, instrumentId: id });

  if (!id) return <div style={{ padding: 20 }}>Invalid instrument.</div>;
  if (query.isLoading) return <div style={{ padding: 20 }}>Loading summary…</div>;
  if (query.error || !query.data) return <div style={{ padding: 20 }}>Failed to load summary.</div>;

  return (
    <div style={{ padding: 20, display: 'grid', gap: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <h1 style={{ margin: 0 }}>Instrument Summary</h1>
          <div style={{ opacity: 0.75 }}>{query.data.identity.symbol} · {id}</div>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <Link to="/instruments" style={{ padding: '10px 14px', background: '#1f2937', borderRadius: 8 }}>Back to Instruments</Link>
          <Link to="/workspace" style={{ padding: '10px 14px', background: '#2563eb', borderRadius: 8 }}>Open Workspace</Link>
        </div>
      </div>
      <InstrumentSummaryPanel summary={query.data} />
    </div>
  );
}
