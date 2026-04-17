import { Link } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useAlertRulesQuery, useUpdateAlertStatusMutation } from '../hooks/api/useWatchlistConsole';

export default function AlertsPage() {
  const userId = useWorkspaceStore((s) => s.userId);
  const alerts = useAlertRulesQuery(userId);
  const update = useUpdateAlertStatusMutation(userId);
  return <div style={{ padding:20, display:'grid', gap:16 }}>
    <div><h1 style={{ margin:0 }}>Alerts Console</h1><div style={{ opacity:0.75 }}>Rules created from screener bulk actions and watchlist domain integration</div></div>
    <div style={{ border:'1px solid #243043', borderRadius:8, background:'#111827', padding:16 }}>
      <table style={{ width:'100%', borderCollapse:'collapse' }}><thead><tr><th style={th}>Symbol</th><th style={th}>Rule</th><th style={th}>Type</th><th style={th}>Status</th><th style={th}>Actions</th></tr></thead><tbody>{(alerts.data ?? []).map((r) => <tr key={r.alertRuleId}><td style={td}>{r.symbol ?? r.instrumentId}</td><td style={td}>{r.ruleName}</td><td style={td}>{r.ruleType}</td><td style={td}>{r.status}</td><td style={td}><div style={{ display:'flex', gap:8, flexWrap:'wrap' }}><button onClick={() => update.mutate({ alertRuleId: r.alertRuleId, status: r.status === 'ACTIVE' ? 'PAUSED' : 'ACTIVE' })}>{r.status === 'ACTIVE' ? 'Pause' : 'Activate'}</button><Link to={`/alerts/${r.alertRuleId}`} style={{ color:'#60a5fa' }}>Open Detail</Link></div></td></tr>)}</tbody></table>
    </div>
  </div>;
}
const th = { textAlign:'left', padding:'8px 6px', borderBottom:'1px solid #243043' } as const;
const td = { padding:'8px 6px', borderBottom:'1px solid #1f2937' } as const;
