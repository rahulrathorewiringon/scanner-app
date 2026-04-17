import { useMemo, useState } from 'react';
import FlexLayout from 'flexlayout-react';
import 'flexlayout-react/style/light.css';
import MultiTimeframeChartSet from '../chart-workbench/MultiTimeframeChartSet';
import { useInstrumentSummaryQuery } from '../hooks/api/useInstrumentSummaryQuery';
import { useDeleteWorkspaceLayoutPresetMutation, useMarkDefaultWorkspaceLayoutPresetMutation, useMarkFavoriteWorkspaceLayoutPresetMutation, useSaveWorkspaceLayoutPresetMutation, useWorkspaceLayoutPresetsQuery } from '../hooks/api/useWorkspaceLayoutPresets';
import { useWorkspaceStore } from '../stores/workspace.store';

const DEFAULT_MODEL = {
  global: {},
  layout: {
    type: 'row',
    children: [
      { type: 'tabset', weight: 68, children: [{ type: 'tab', name: 'Charts', component: 'charts' }] },
      { type: 'tabset', weight: 32, children: [
        { type: 'tab', name: 'Symbol Context', component: 'context' },
        { type: 'tab', name: 'Inspection', component: 'inspection' },
        { type: 'tab', name: 'Marker Legend', component: 'legend' },
        { type: 'tab', name: 'Pivot Timeline', component: 'timeline' },
      ] },
    ],
  },
};

function SymbolContextPane() {
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const tradeDate = useWorkspaceStore((s) => s.tradeDate);
  const instrumentId = useWorkspaceStore((s) => s.activeInstrumentId);
  const q = useInstrumentSummaryQuery({ exchangeCode, tradeDate, instrumentId });
  if (q.isLoading) return <div style={{ padding: 12 }}>Loading context…</div>;
  if (q.error || !q.data) return <div style={{ padding: 12 }}>Failed to load context.</div>;
  return <div style={{ padding: 12, display:'grid', gap:10 }}>
    <div style={{ fontSize: 18, fontWeight: 700 }}>{q.data.identity.symbol}</div>
    <div>Trend: {q.data.trend.state ?? '—'}</div>
    <div>Daily SMA: {q.data.smaStructure?.day ?? '—'}</div>
    <div>Pivot: {q.data.pivots?.latestPivotType ?? '—'}</div>
    <div>Candle: {q.data.candleAnalysis?.currentPattern ?? '—'}</div>
  </div>;
}

function InspectionPane() {
  const crosshair = useWorkspaceStore((s) => s.crosshair);
  const visibleRange = useWorkspaceStore((s) => s.visibleRange);
  const hoverSync = useWorkspaceStore((s) => s.hoverSync);
  return <div style={{ padding: 12, display:'grid', gap:8 }}>
    <div style={{ fontSize: 16, fontWeight: 700 }}>Crosshair Inspection</div>
    <div>Source: {crosshair.source ?? '—'}</div><div>Time: {crosshair.time ?? '—'}</div>
    <div>Open: {crosshair.open ?? '—'}</div><div>High: {crosshair.high ?? '—'}</div><div>Low: {crosshair.low ?? '—'}</div><div>Close: {crosshair.close ?? '—'}</div>
    <div>Pivot: {crosshair.pivotType ?? '—'}</div><div>Trend Pivot: {crosshair.trendPivotType ?? '—'}</div>
    <div>Range: {visibleRange.from != null && visibleRange.to != null ? `${visibleRange.from.toFixed(2)} → ${visibleRange.to.toFixed(2)}` : '—'}</div>
    <div>Hover Sync: {hoverSync.time ?? '—'} @ {hoverSync.price ?? '—'}</div>
  </div>;
}

function MarkerLegendPane() {
  const markerLegend = useWorkspaceStore((s) => s.markerLegend);
  return <div style={{ padding: 12, display:'grid', gap:8 }}>
    <div style={{ fontSize: 16, fontWeight: 700 }}>Marker Legend</div>
    {markerLegend.map((item) => <div key={item.label} style={{ borderBottom:'1px solid #243043', paddingBottom:6 }}><strong>{item.label}</strong> — {item.description}</div>)}
  </div>;
}

function PivotTimelinePane() {
  const pivotTimeline = useWorkspaceStore((s) => s.pivotTimeline);
  const setVisibleRange = useWorkspaceStore((s) => s.setVisibleRange);
  return <div style={{ padding: 12, display:'grid', gap:8, maxHeight:'100%', overflow:'auto' }}>
    <div style={{ fontSize: 16, fontWeight: 700 }}>Pivot Event Timeline</div>
    {pivotTimeline.length === 0 ? <div>No pivot events.</div> : pivotTimeline.map((item, idx) => <button key={`${item.timeframe}-${item.barStartTs}-${idx}`} onClick={() => setVisibleRange({ jumpToTime: item.barStartTs.slice(0, 10) })} style={{ textAlign:'left', border:'1px solid #243043', borderRadius:8, padding:8, background:'#0f172a', color:'inherit' }}>
      <div><strong>{item.timeframe.toUpperCase()}</strong> · {item.barStartTs}</div>
      <div>Pivot: {item.pivotType ?? '—'} / Trend: {item.trendPivotType ?? '—'}</div>
      <div>Price: {item.pivotPrice ?? '—'}</div>
    </button>)}
  </div>;
}

export default function DockingWorkspace() {
  const userId = useWorkspaceStore((s) => s.userId);
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const workspaceModelJson = useWorkspaceStore((s) => s.workspaceModelJson);
  const setWorkspaceModelJson = useWorkspaceStore((s) => s.setWorkspaceModelJson);
  const [presetName, setPresetName] = useState('');
  const presetsQuery = useWorkspaceLayoutPresetsQuery(userId);
  const savePresetMutation = useSaveWorkspaceLayoutPresetMutation();
  const deletePresetMutation = useDeleteWorkspaceLayoutPresetMutation(userId);
  const markDefaultMutation = useMarkDefaultWorkspaceLayoutPresetMutation(userId);
  const markFavoriteMutation = useMarkFavoriteWorkspaceLayoutPresetMutation(userId);

  const initialModel = useMemo(() => {
    const raw = workspaceModelJson ?? localStorage.getItem('stockanalysis:flexlayout:model');
    try { return FlexLayout.Model.fromJson(raw ? JSON.parse(raw) : DEFAULT_MODEL); }
    catch { return FlexLayout.Model.fromJson(DEFAULT_MODEL); }
  }, []);
  const [model] = useState(initialModel);

  const persistModel = () => {
    const json = JSON.stringify(model.toJson());
    localStorage.setItem('stockanalysis:flexlayout:model', json);
    setWorkspaceModelJson(json);
  };
  const resetModel = () => {
    localStorage.removeItem('stockanalysis:flexlayout:model');
    setWorkspaceModelJson(JSON.stringify(DEFAULT_MODEL));
    window.location.reload();
  };
  const savePreset = () => {
    const name = presetName.trim();
    if (!name) return;
    savePresetMutation.mutate({ userId, name, exchangeCode, layoutJson: model.toJson() as unknown as Record<string, unknown>, isDefault: false, isFavorite: false });
    setPresetName('');
  };
  const loadPreset = (layoutJson: Record<string, unknown>) => {
    const json = JSON.stringify(layoutJson);
    localStorage.setItem('stockanalysis:flexlayout:model', json);
    setWorkspaceModelJson(json);
    window.location.reload();
  };

  const factory = (node: any) => {
    const component = node.getComponent();
    if (component === 'charts') return <MultiTimeframeChartSet />;
    if (component === 'context') return <SymbolContextPane />;
    if (component === 'inspection') return <InspectionPane />;
    if (component === 'legend') return <MarkerLegendPane />;
    if (component === 'timeline') return <PivotTimelinePane />;
    return <div>Unknown tab</div>;
  };

  return <div style={{ display:'grid', gridTemplateRows:'auto 1fr', height:'100%' }}>
    <div style={{ display:'grid', gap:10, padding:'8px 12px', borderBottom:'1px solid #243043' }}>
      <div style={{ display:'flex', gap:10 }}>
        <button onClick={persistModel}>Save Local Layout</button>
        <button onClick={resetModel}>Reset Layout</button>
        <input value={presetName} onChange={(e) => setPresetName(e.target.value)} placeholder="Preset name" />
        <button onClick={savePreset}>Save Preset</button>
      </div>
      <div style={{ display:'flex', gap:8, flexWrap:'wrap' }}>
        {(presetsQuery.data ?? []).map((preset) => <div key={preset.presetId} style={{ border:'1px solid #243043', borderRadius:8, padding:'6px 8px', display:'flex', gap:8, alignItems:'center' }}>
          <strong>{preset.name}</strong>
          {preset.isDefault && <span>★ Default</span>}
          {preset.isFavorite && <span>♥ Favorite</span>}
          <button onClick={() => loadPreset(preset.layoutJson)}>Load</button>
          <button onClick={() => markDefaultMutation.mutate(preset.presetId)}>Set Default</button>
          <button onClick={() => markFavoriteMutation.mutate({ presetId: preset.presetId, favorite: !preset.isFavorite })}>{preset.isFavorite ? 'Unfavorite' : 'Favorite'}</button>
          <button onClick={() => deletePresetMutation.mutate(preset.presetId)}>Delete</button>
        </div>)}
      </div>
    </div>
    <FlexLayout.Layout model={model} factory={factory} onModelChange={persistModel} />
  </div>;
}
