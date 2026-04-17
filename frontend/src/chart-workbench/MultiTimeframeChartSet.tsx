import { useEffect, useMemo } from 'react';
import ChartPane from './ChartPane';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useMultiTimeframeChartsQuery } from '../hooks/api/useMultiTimeframeChartsQuery';
import { SynchronizedChartManager } from './SynchronizedChartManager';
import { Link } from 'react-router-dom';
import type { PivotTimelineEvent } from '../types/chart.types';

export default function MultiTimeframeChartSet() {
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const instrumentId = useWorkspaceStore((s) => s.activeInstrumentId);
  const selectedTimeframes = useWorkspaceStore((s) => s.selectedTimeframes);
  const syncEnabled = useWorkspaceStore((s) => s.syncEnabled);
  const setSyncEnabled = useWorkspaceStore((s) => s.setSyncEnabled);
  const setCrosshair = useWorkspaceStore((s) => s.setCrosshair);
  const crosshair = useWorkspaceStore((s) => s.crosshair);
  const visibleRange = useWorkspaceStore((s) => s.visibleRange);
  const setPivotTimeline = useWorkspaceStore((s) => s.setPivotTimeline);
  const setMarkerLegend = useWorkspaceStore((s) => s.setMarkerLegend);
  const manager = useMemo(() => new SynchronizedChartManager(), []);
  const { data, isLoading, error } = useMultiTimeframeChartsQuery({ exchangeCode, instrumentId });

  useEffect(() => {
    const unsub = manager.onCrosshair((state) => setCrosshair(state));
    return unsub;
  }, [manager, setCrosshair]);

  useEffect(() => {
    const timeline: PivotTimelineEvent[] = [];
    const legend = [
      { label: 'PH', description: 'Pivot High marker' },
      { label: 'PL', description: 'Pivot Low marker' },
      { label: 'HH/HL/LH/LL', description: 'Trend pivot classification' },
      { label: 'SMA 5/10/20', description: 'Overlay moving averages' },
    ];
    (['week', 'day', 'hour'] as const).forEach((tf) => {
      (data?.overlays?.[tf]?.pivots ?? []).forEach((pivot) => {
        timeline.push({
          timeframe: tf,
          barStartTs: pivot.barStartTs,
          pivotType: pivot.pivotType,
          trendPivotType: pivot.trendPivotType,
          pivotPrice: pivot.pivotPrice,
        });
      });
    });
    timeline.sort((a, b) => b.barStartTs.localeCompare(a.barStartTs));
    setPivotTimeline(timeline.slice(0, 50));
    setMarkerLegend(legend);
  }, [data, setPivotTimeline, setMarkerLegend]);

  if (isLoading) return <div style={{ padding: 12 }}>Loading charts…</div>;
  if (error) return <div style={{ padding: 12 }}>Failed to load charts.</div>;

  const summarySeries = [data?.series.week, data?.series.day, data?.series.hour].filter(Boolean);
  const bars = summarySeries.reduce((sum, s) => sum + (s?.candles.length ?? 0), 0);

  return (
    <div style={{ display: 'grid', gap: 12, padding: 12 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <div style={{ fontSize: 20, fontWeight: 700 }}>{data?.symbol ?? 'Instrument'} · {instrumentId}</div>
          <div style={{ opacity: 0.75 }}>Total visible data bars: {bars}</div>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <button onClick={() => setSyncEnabled(!syncEnabled)} style={{ padding: '8px 12px' }}>
            Sync {syncEnabled ? 'On' : 'Off'}
          </button>
          <button onClick={() => manager.fitContent()} style={{ padding: '8px 12px' }}>Fit Content</button>
          <button onClick={() => manager.clearCrosshair()} style={{ padding: '8px 12px' }}>Clear Crosshair</button>
          <Link to={`/instruments/${instrumentId}/summary`} style={{ padding: '8px 12px', background: '#1f2937', borderRadius: 8 }}>Summary</Link>
        </div>
      </div>

      <div style={{ display:'grid', gridTemplateColumns:'repeat(6, minmax(0,1fr))', gap:12 }}>
        <SummaryBadge label="Weekly Pivot" value={data?.overlays?.week?.pivots?.[0]?.pivotType ?? '—'} />
        <SummaryBadge label="Daily Pivot" value={data?.overlays?.day?.pivots?.[0]?.pivotType ?? '—'} />
        <SummaryBadge label="Hourly Pivot" value={data?.overlays?.hour?.pivots?.[0]?.pivotType ?? '—'} />
        <SummaryBadge label="Sync" value={syncEnabled ? 'Enabled' : 'Disabled'} />
        <SummaryBadge label="Crosshair" value={crosshair.time ?? '—'} />
        <SummaryBadge label="Visible Range" value={visibleRange.from != null && visibleRange.to != null ? `${visibleRange.from.toFixed(1)} → ${visibleRange.to.toFixed(1)}` : '—'} />
      </div>

      {selectedTimeframes.includes('week') && <ChartPane chartKey="week" title="Weekly" series={data?.series.week} overlay={data?.overlays?.week} syncManager={syncEnabled ? manager : undefined} />}
      {selectedTimeframes.includes('day') && <ChartPane chartKey="day" title="Daily" series={data?.series.day} overlay={data?.overlays?.day} syncManager={syncEnabled ? manager : undefined} />}
      {selectedTimeframes.includes('hour') && <ChartPane chartKey="hour" title="Hourly" series={data?.series.hour} overlay={data?.overlays?.hour} syncManager={syncEnabled ? manager : undefined} />}
    </div>
  );
}

function SummaryBadge({ label, value }: { label: string; value: string }) {
  return (
    <div style={{ border:'1px solid #243043', borderRadius:8, background:'#111827', padding:12 }}>
      <div style={{ opacity:0.75, fontSize:12 }}>{label}</div>
      <div style={{ fontWeight:700 }}>{value}</div>
    </div>
  );
}
