import type { InstrumentSummaryDto } from '../types/instrument.types';

export default function InstrumentSummaryPanel({ summary }: { summary: InstrumentSummaryDto }) {
  return (
    <div style={{ display: 'grid', gap: 12 }}>
      <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
        <div style={{ fontSize: 22, fontWeight: 700 }}>{summary.identity.symbol}</div>
        <div>{summary.identity.instrumentType} · {summary.identity.exchangeCode}</div>
        <div>{summary.identity.sector ?? '—'} / {summary.identity.industry ?? '—'}</div>
      </div>

      <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827', display:'grid', gap: 6 }}>
        <strong>Availability</strong>
        <div>Chart Data: {String(summary.dataAvailability.chartDataExists)}</div>
        <div>Bootstrap: {summary.dataAvailability.bootstrapStatus}</div>
        <div>Timeframes: {summary.dataAvailability.chartTimeframesAvailable.join(', ') || '—'}</div>
        <div>Chart To: {summary.dataAvailability.chartToDate ?? '—'}</div>
      </div>

      <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827', display:'grid', gap: 6 }}>
        <strong>Trend + Structure</strong>
        <div>Trend: {summary.trend.state ?? '—'} ({summary.trend.timeframe ?? '—'})</div>
        <div>Daily SMA: {summary.smaStructure?.day ?? '—'}</div>
        <div>Hourly SMA: {summary.smaStructure?.hour ?? '—'}</div>
        <div>Weekly SMA: {summary.smaStructure?.week ?? '—'}</div>
      </div>

      <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827', display:'grid', gap: 6 }}>
        <strong>Pivots + Candle</strong>
        <div>Latest Pivot: {summary.pivots?.latestPivotType ?? '—'}</div>
        <div>Trend Pivot: {summary.pivots?.latestTrendPivotType ?? '—'}</div>
        <div>Previous Pivot: {summary.pivots?.previousPivotType ?? '—'}</div>
        <div>Current Candle: {summary.candleAnalysis?.currentPattern ?? '—'}</div>
      </div>

      {!!summary.pivots?.recentSequence?.length && (
        <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 16, background: '#111827' }}>
          <strong>Recent Pivot Sequence</strong>
          <div style={{ display: 'grid', gap: 6, marginTop: 8 }}>
            {summary.pivots.recentSequence.slice(0, 8).map((item, idx) => (
              <div key={idx} style={{ display: 'grid', gridTemplateColumns: '70px 90px 90px 1fr', gap: 8 }}>
                <span>{item.timeframe}</span>
                <span>{item.pivotType ?? '—'}</span>
                <span>{item.trendPivotType ?? '—'}</span>
                <span>{item.barStartTs}</span>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
