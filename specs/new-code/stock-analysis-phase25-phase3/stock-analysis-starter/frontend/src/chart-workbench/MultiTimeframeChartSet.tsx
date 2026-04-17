import ChartPane from './ChartPane';
import { useWorkspaceStore } from '../stores/workspace.store';
import { useMultiTimeframeChartsQuery } from '../hooks/api/useMultiTimeframeChartsQuery';

export default function MultiTimeframeChartSet() {
  const exchangeCode = useWorkspaceStore((s) => s.exchangeCode);
  const instrumentId = useWorkspaceStore((s) => s.activeInstrumentId);
  const { data, isLoading, error } = useMultiTimeframeChartsQuery({ exchangeCode, instrumentId });

  if (isLoading) return <div style={{ padding: 12 }}>Loading charts…</div>;
  if (error) return <div style={{ padding: 12 }}>Failed to load charts.</div>;

  return (
    <div style={{ display: 'grid', gap: 12, padding: 12 }}>
      <div style={{ fontSize: 20, fontWeight: 700 }}>{data?.symbol ?? 'Instrument'} · {instrumentId}</div>
      <ChartPane title="Weekly" series={data?.series.week} overlay={data?.overlays?.week} />
      <ChartPane title="Daily" series={data?.series.day} overlay={data?.overlays?.day} />
      <ChartPane title="Hourly" series={data?.series.hour} overlay={data?.overlays?.hour} />
    </div>
  );
}
