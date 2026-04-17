import { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useCreateWatchlistMutation, useDeleteWatchlistRuleMutation, useGenerateWatchlistRuleMutation, useSaveWatchlistRuleMutation, useUpdateWatchlistRuleMutation, useWatchlistRulesQuery, useWatchlistsQuery } from '../hooks/api/useWatchlistConsole';

export default function WatchlistsPage() {
  const userId = useWorkspaceStore((s) => s.userId);
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const watchlists = useWatchlistsQuery(userId);
  const createWatchlist = useCreateWatchlistMutation(userId);
  const rules = useWatchlistRulesQuery(userId);
  const saveRule = useSaveWatchlistRuleMutation(userId);
  const updateRule = useUpdateWatchlistRuleMutation(userId);
  const deleteRule = useDeleteWatchlistRuleMutation(userId);
  const generateRule = useGenerateWatchlistRuleMutation(userId);
  const [selectedWatchlistId, setSelectedWatchlistId] = useState<string | null>(null);
  const [editingRuleId, setEditingRuleId] = useState<string | null>(null);
  const [watchlistName, setWatchlistName] = useState('My Watchlist');
  const [name, setName] = useState('Momentum Daily');
  const [filterJson, setFilterJson] = useState('{"type":"group","id":"root","operator":"AND","enabled":true,"children":[]}');

  const selectedWatchlist = useMemo(() => (watchlists.data ?? [])[0]?.watchlistId ?? null, [watchlists.data]);
  const effectiveWatchlistId = selectedWatchlistId ?? selectedWatchlist;

  const saveCurrentRule = () => {
    if (!effectiveWatchlistId) return;
    const payload = { tradeDate, defaultTimeframe: 'day', pageSize: 200, filterTree: JSON.parse(filterJson) } as Record<string, unknown>;
    if (editingRuleId) {
      updateRule.mutate({ ruleId: editingRuleId, userId, watchlistId: effectiveWatchlistId, name, exchangeCode, ruleType: 'JSON_SCREENER_FILTER', ruleDefinition: payload, isEnabled: true });
      setEditingRuleId(null);
    } else {
      saveRule.mutate({ userId, watchlistId: effectiveWatchlistId, name, exchangeCode, ruleType: 'JSON_SCREENER_FILTER', ruleDefinition: payload, isEnabled: true });
    }
  };

  return <div style={{ padding:20, display:'grid', gap:16 }}>
    <div><h1 style={{ margin:0 }}>Watchlists Console</h1><div style={{ opacity:0.75 }}>Create, drill into, and manage watchlists and JSON generation rules</div></div>
    <div style={{ display:'grid', gridTemplateColumns:'0.8fr 1.2fr 1fr', gap:16 }}>
      <section style={card}><h3>Watchlists</h3><input value={watchlistName} onChange={(e)=>setWatchlistName(e.target.value)} style={input} /><button onClick={() => createWatchlist.mutate({ userId, name: watchlistName, exchangeCode, watchlistType: 'MANUAL', ruleEngineType: null as any })}>Create Watchlist</button>{(watchlists.data ?? []).map((w) => <div key={w.watchlistId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginTop:8 }}><div><strong>{w.name}</strong> · {w.watchlistType}</div><div style={{ display:'flex', gap:8, marginTop:8 }}><button onClick={() => setSelectedWatchlistId(w.watchlistId)}>Select</button><Link to={`/watchlists/${w.watchlistId}`} style={{ color:'#60a5fa' }}>Open Detail</Link></div></div>)}</section>
      <section style={card}><h3>Rule Engine</h3><input value={name} onChange={(e) => setName(e.target.value)} placeholder='Rule name' style={input}/><textarea value={filterJson} onChange={(e) => setFilterJson(e.target.value)} rows={10} style={{ ...input, fontFamily:'monospace' }} /><div style={{ display:'flex', gap:8, flexWrap:'wrap' }}><button onClick={saveCurrentRule}>{editingRuleId ? 'Update Rule' : 'Save Rule'}</button>{editingRuleId && <button onClick={() => setEditingRuleId(null)}>Cancel</button>}</div></section>
      <section style={card}><h3>Saved Rules</h3>{(rules.data ?? []).map((r) => <div key={r.ruleId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginBottom:8 }}><strong>{r.name}</strong><div>{r.ruleType} · {r.isEnabled ? 'Enabled' : 'Disabled'}</div><div style={{ display:'flex', gap:8, flexWrap:'wrap', marginTop:8 }}><button onClick={() => { setEditingRuleId(r.ruleId); setName(r.name); setFilterJson(JSON.stringify(r.ruleDefinition, null, 2)); }}>Edit</button><button onClick={() => generateRule.mutate(r.ruleId)}>Generate</button><button onClick={() => deleteRule.mutate(r.ruleId)}>Delete</button></div></div>)}</section>
    </div>
  </div>;
}
const card = { border:'1px solid #243043', borderRadius:8, background:'#111827', padding:16 } as const;
const input = { width:'100%', padding:8, marginBottom:8, background:'#0f172a', color:'inherit', border:'1px solid #243043', borderRadius:8 } as const;
