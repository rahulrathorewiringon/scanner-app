import { useEffect, useRef } from 'react';
import { createChart, type IChartApi, type CandlestickData, type LineData } from 'lightweight-charts';
import type { ChartSeriesDto, ChartOverlayDto } from '../types/chart.types';

interface Props {
  title: string;
  series?: ChartSeriesDto | null;
  overlay?: ChartOverlayDto | null;
}

export default function ChartPane({ title, series, overlay }: Props) {
  const ref = useRef<HTMLDivElement | null>(null);
  const chartRef = useRef<IChartApi | null>(null);

  useEffect(() => {
    if (!ref.current) return;
    const chart = createChart(ref.current, {
      layout: { background: { color: '#0b1220' }, textColor: '#cbd5e1' },
      width: ref.current.clientWidth,
      height: 220,
      rightPriceScale: { visible: true },
      timeScale: { visible: true },
      grid: { vertLines: { color: '#1f2937' }, horzLines: { color: '#1f2937' } },
    });
    chartRef.current = chart;
    const candleSeries = chart.addCandlestickSeries();
    const data: CandlestickData[] = (series?.candles ?? []).map((c) => ({
      time: c.barStartTs.slice(0, 10), open: c.open, high: c.high, low: c.low, close: c.close,
    }));
    candleSeries.setData(data);

    const maybeAddLine = (points?: { time: string; value: number }[]) => {
      if (!points?.length) return;
      const line = chart.addLineSeries();
      line.setData(points.map((p) => ({ time: p.time.slice(0, 10), value: p.value }) as LineData));
    };
    maybeAddLine(overlay?.sma?.sma5);
    maybeAddLine(overlay?.sma?.sma10);
    maybeAddLine(overlay?.sma?.sma20);

    const handleResize = () => {
      if (ref.current) chart.applyOptions({ width: ref.current.clientWidth });
    };
    window.addEventListener('resize', handleResize);
    return () => {
      window.removeEventListener('resize', handleResize);
      chart.remove();
    };
  }, [series, overlay]);

  return (
    <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 8, background: '#111827' }}>
      <div style={{ marginBottom: 8, fontWeight: 700 }}>{title}</div>
      <div ref={ref} />
    </div>
  );
}
