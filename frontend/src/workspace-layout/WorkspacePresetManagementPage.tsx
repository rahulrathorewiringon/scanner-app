import { useState } from 'react';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useDeleteWorkspaceLayoutPresetMutation, useDeleteWorkspaceLayoutPresetShareMutation, useMarkDefaultWorkspaceLayoutPresetMutation, useMarkFavoriteWorkspaceLayoutPresetMutation, useSaveWorkspaceLayoutPresetMutation, useSaveWorkspaceLayoutPresetShareMutation, useSharedWorkspaceLayoutPresetsQuery, useUpdateWorkspaceLayoutPresetMutation, useUpdateWorkspaceLayoutPresetSharePermissionMutation, useWorkspaceLayoutPresetSharesQuery, useWorkspaceLayoutPresetsQuery } from '../hooks/api/useWorkspaceLayoutPresets';

export default function WorkspacePresetManagementPage() {
  const userId = useWorkspaceStore((s) => s.userId);
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const workspaceModelJson = useWorkspaceStore((s) => s.workspaceModelJson);
  const presets = useWorkspaceLayoutPresetsQuery(userId);
  const sharedPresets = useSharedWorkspaceLayoutPresetsQuery(userId);
  const savePreset = useSaveWorkspaceLayoutPresetMutation();
  const updatePreset = useUpdateWorkspaceLayoutPresetMutation();
  const deletePreset = useDeleteWorkspaceLayoutPresetMutation(userId);
  const markDefault = useMarkDefaultWorkspaceLayoutPresetMutation(userId);
  const markFavorite = useMarkFavoriteWorkspaceLayoutPresetMutation(userId);
  const [name, setName] = useState('My Layout');
  const [editingId, setEditingId] = useState<string | null>(null);
  const [selectedPresetId, setSelectedPresetId] = useState<string | null>(null);
  const [shareUser, setShareUser] = useState('');
  const [sharePermission, setSharePermission] = useState<'VIEW'|'EDIT'>('VIEW');
  const shares = useWorkspaceLayoutPresetSharesQuery(selectedPresetId, userId);
  const saveShare = useSaveWorkspaceLayoutPresetShareMutation(selectedPresetId ?? '', userId);
  const updateShare = useUpdateWorkspaceLayoutPresetSharePermissionMutation(selectedPresetId ?? '', userId);
  const deleteShare = useDeleteWorkspaceLayoutPresetShareMutation(selectedPresetId ?? '', userId);

  const submit = () => {
    const layoutJson = workspaceModelJson ? JSON.parse(workspaceModelJson) : {};
    if (editingId) updatePreset.mutate({ presetId: editingId, userId, name, exchangeCode, layoutJson, isDefault: false, isFavorite: false });
    else savePreset.mutate({ userId, name, exchangeCode, layoutJson, isDefault: false, isFavorite: false });
    setEditingId(null); setName('My Layout');
  };

  return <div style={{ padding:20, display:'grid', gap:16 }}>
    <div><h1 style={{ margin:0 }}>Workspace Preset Management</h1><div style={{ opacity:0.75 }}>Owned presets, shared presets, and share permissions</div></div>
    <div style={{ display:'grid', gridTemplateColumns:'0.8fr 1.2fr 1fr', gap:16 }}>
      <section style={card}><input value={name} onChange={(e) => setName(e.target.value)} style={input} /><button onClick={submit}>{editingId ? 'Update Preset' : 'Save Preset'}</button></section>
      <section style={card}><h3>Owned Presets</h3>{(presets.data ?? []).map((p) => <div key={p.presetId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginBottom:8 }}><div><strong>{p.name}</strong> {p.isDefault ? '★' : ''} {p.isFavorite ? '♥' : ''}</div><div style={{ display:'flex', gap:8, flexWrap:'wrap', marginTop:8 }}><button onClick={() => { setEditingId(p.presetId); setName(p.name); }}>Edit</button><button onClick={() => markDefault.mutate(p.presetId)}>Default</button><button onClick={() => markFavorite.mutate({ presetId: p.presetId, favorite: !p.isFavorite })}>{p.isFavorite ? 'Unfavorite' : 'Favorite'}</button><button onClick={() => deletePreset.mutate(p.presetId)}>Delete</button><button onClick={() => setSelectedPresetId(p.presetId)}>Shares</button></div></div>)}</section>
      <section style={card}><h3>Shared With Me</h3>{(sharedPresets.data ?? []).map((p) => <div key={p.presetId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginBottom:8 }}><strong>{p.name}</strong><div style={{ fontSize:12, opacity:0.75 }}>{p.userId}</div></div>)}<h3>Preset Shares</h3>{selectedPresetId ? <><input value={shareUser} onChange={(e)=>setShareUser(e.target.value)} placeholder='shared user id' style={input} /><select value={sharePermission} onChange={(e)=>setSharePermission(e.target.value as any)} style={input}><option value='VIEW'>VIEW</option><option value='EDIT'>EDIT</option></select><button onClick={() => saveShare.mutate({ sharedWithUserId: shareUser, permission: sharePermission })}>Share Preset</button>{(shares.data ?? []).map((s) => <div key={s.shareId} style={{ border:'1px solid #243043', borderRadius:8, padding:8, marginTop:8 }}><div><strong>{s.sharedWithUserId}</strong> · {s.permission}</div><div style={{ display:'flex', gap:8, marginTop:8 }}><button onClick={() => updateShare.mutate({ sharedWithUserId: s.sharedWithUserId, permission: s.permission === 'VIEW' ? 'EDIT' : 'VIEW' })}>Toggle Permission</button><button onClick={() => deleteShare.mutate(s.sharedWithUserId)}>Remove</button></div></div>)}</> : <div>Select an owned preset to manage sharing.</div>}</section>
    </div>
  </div>;
}
const card = { border:'1px solid #243043', borderRadius:8, background:'#111827', padding:16 } as const;
const input = { width:'100%', padding:8, marginBottom:8, background:'#0f172a', color:'inherit', border:'1px solid #243043', borderRadius:8 } as const;
