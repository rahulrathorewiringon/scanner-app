import { useMemo, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useAlertRuleDetailQuery, useDeleteAlertRuleMutation, useUpdateAlertRuleMutation } from '../hooks/api/useWatchlistConsole';

export default function AlertDetailPage() {
  const { alertRuleId } = useParams();
  const userId = useWorkspaceStore((s) => s.userId);
  const detail = useAlertRuleDetailQuery(userId, alertRuleId);
  const updateAlert = useUpdateAlertRuleMutation(userId);
  const deleteAlert = useDeleteAlertRuleMutation(userId);
  const navigate = useNavigate();
  const [ruleName, setRuleName] = useState('');
  const [ruleType, setRuleType] = useState('');
  const [status, setStatus] = useState('ACTIVE');
  const [configJson, setConfigJson] = useState('{}');
  const alert = detail.data;
  useMemo(() => {
    if (alert) { setRuleName(alert.ruleName); setRuleType(alert.ruleType); setStatus(alert.status); setConfigJson(alert.configJson ?? '{}'); }
  }, [alert]);

  return <div style={{ padding:20, display:'grid', gap:16 }}>
    <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center' }}><div><h1 style={{ margin:0 }}>Alert Detail</h1><div style={{ opacity:0.75 }}>{alert?.symbol ?? alertRuleId}</div></div><button onClick={() => navigate('/alerts')}>Back</button></div>
    <section style={card}>
      <input style={input} value={ruleName} onChange={(e)=>setRuleName(e.target.value)} placeholder='Rule name' />
      <input style={input} value={ruleType} onChange={(e)=>setRuleType(e.target.value)} placeholder='Rule type' />
      <select style={input} value={status} onChange={(e)=>setStatus(e.target.value)}><option value='ACTIVE'>ACTIVE</option><option value='PAUSED'>PAUSED</option></select>
      <textarea style={{ ...input, minHeight:180, fontFamily:'monospace' }} value={configJson} onChange={(e)=>setConfigJson(e.target.value)} />
      <div style={{ display:'flex', gap:8, flexWrap:'wrap' }}>
        <button onClick={() => alert && updateAlert.mutate({ alertRuleId: alert.alertRuleId, userId, ruleName, ruleType, status, configJson })}>Save</button>
        <button onClick={() => alert && deleteAlert.mutate(alert.alertRuleId, { onSuccess: () => navigate('/alerts') })}>Delete</button>
      </div>
    </section>
  </div>;
}
const card = { border:'1px solid #243043', borderRadius:8, background:'#111827', padding:16 } as const;
const input = { width:'100%', padding:8, marginBottom:8, background:'#0f172a', color:'inherit', border:'1px solid #243043', borderRadius:8 } as const;
