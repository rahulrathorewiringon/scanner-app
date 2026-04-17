import { useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useAddWatchlistItemMutation, useDeleteWatchlistItemMutation, useDeleteWatchlistMutation, useUpdateWatchlistItemMutation, useUpdateWatchlistMutation, useWatchlistDetailQuery } from '../hooks/api/useWatchlistConsole';

export default function WatchlistDetailPage() {
  const { watchlistId } = useParams();
  const userId = useWorkspaceStore((s) => s.userId);
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const detail = useWatchlistDetailQuery(userId, watchlistId);
  const updateWatchlist = useUpdateWatchlistMutation(userId);
  const deleteWatchlist = useDeleteWatchlistMutation(userId);
  const addItem = useAddWatchlistItemMutation(userId, watchlistId!);
  const updateItem = useUpdateWatchlistItemMutation(userId, watchlistId!);
  const deleteItem = useDeleteWatchlistItemMutation(userId, watchlistId!);
  const navigate = useNavigate();
  const [name, setName] = useState('');
  const [instrumentId, setInstrumentId] = useState('');
  const [editingItemId, setEditingItemId] = useState<string | null>(null);
  const [note, setNote] = useState('');

  const watchlist = detail.data?.watchlist;
  useMemo(() => { if (watchlist && !name) setName(watchlist.name); }, [watchlist]);

  return <div style={{ padding:20, display:'grid', gap:16 }}>
    <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center' }}><div><h1 style={{ margin:0 }}>Watchlist Detail</h1><div style={{ opacity:0.75 }}>{watchlist?.name ?? watchlistId}</div></div><button onClick={() => navigate('/watchlists')}>Back</button></div>
    <div style={{ display:'grid', gridTemplateColumns:'0.8fr 1.2fr', gap:16 }}>
      <section style={card}>
        <h3>Watchlist</h3>
        <input style={input} value={name} onChange={(e)=>setName(e.target.value)} />
        <div style={{ display:'flex', gap:8, flexWrap:'wrap' }}>
          <button onClick={() => watchlist && updateWatchlist.mutate({ watchlistId: watchlist.watchlistId, userId, name, exchangeCode: watchlist.exchangeCode, watchlistType: watchlist.watchlistType, ruleEngineType: watchlist.ruleEngineType ?? undefined })}>Save</button>
          <button onClick={() => { if (watchlist) { deleteWatchlist.mutate(watchlist.watchlistId, { onSuccess: () => navigate('/watchlists') }); } }}>Delete</button>
        </div>
        <h4 style={{ marginBottom:8 }}>Manual Item Edit</h4>
        <input style={input} placeholder='Instrument ID' value={instrumentId} onChange={(e)=>setInstrumentId(e.target.value)} />
        <input style={input} placeholder='Note' value={note} onChange={(e)=>setNote(e.target.value)} />
        <button onClick={() => { if (!watchlistId || !instrumentId) return; addItem.mutate({ userId, instrumentId: Number(instrumentId), note }); setInstrumentId(''); setNote(''); }}>Add Item</button>
      </section>
      <section style={card}>
        <h3>Items</h3>
        {(detail.data?.items ?? []).map((item) => (
          <div key={item.watchlistItemId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginBottom:8 }}>
            <div><strong>{item.symbol ?? item.instrumentId}</strong></div>
            <div style={{ fontSize:12, opacity:0.75 }}>Source: {item.sourceRuleId ? 'RULE' : 'MANUAL'}</div>
            {editingItemId === item.watchlistItemId ? (
              <div style={{ display:'grid', gap:8, marginTop:8 }}>
                <input style={input} value={note} onChange={(e)=>setNote(e.target.value)} />
                <div style={{ display:'flex', gap:8 }}>
                  <button onClick={() => updateItem.mutate({ watchlistItemId: item.watchlistItemId, userId, note })}>Save Note</button>
                  <button onClick={() => setEditingItemId(null)}>Cancel</button>
                </div>
              </div>
            ) : <div style={{ marginTop:8 }}>{item.note ?? '—'}</div>}
            <div style={{ display:'flex', gap:8, flexWrap:'wrap', marginTop:8 }}>
              <button onClick={() => { setEditingItemId(item.watchlistItemId); setNote(item.note ?? ''); }}>Edit Note</button>
              <button onClick={() => deleteItem.mutate(item.watchlistItemId)}>Delete Item</button>
            </div>
          </div>
        ))}
      </section>
    </div>
  </div>;
}
const card = { border:'1px solid #243043', borderRadius:8, background:'#111827', padding:16 } as const;
const input = { width:'100%', padding:8, marginBottom:8, background:'#0f172a', color:'inherit', border:'1px solid #243043', borderRadius:8 } as const;
