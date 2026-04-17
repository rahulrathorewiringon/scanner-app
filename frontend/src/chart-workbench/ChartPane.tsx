import { useEffect, useMemo, useRef } from 'react';
import { createChart, type CandlestickData, type HistogramData, type IChartApi, type LineData, type MouseEventParams } from 'lightweight-charts';
import type { ChartSeriesDto, ChartOverlayDto } from '../types/chart.types';
import type { SynchronizedChartManager } from './SynchronizedChartManager';
import { useWorkspaceStore } from '../stores/workspace.store';

interface Props {
  chartKey: 'week' | 'day' | 'hour';
  title: string;
  series?: ChartSeriesDto | null;
  overlay?: ChartOverlayDto | null;
  syncManager?: SynchronizedChartManager;
}

export default function ChartPane({ chartKey, title, series, overlay, syncManager }: Props) {
  const ref = useRef<HTMLDivElement | null>(null);
  const chartRef = useRef<IChartApi | null>(null);
  const setCrosshair = useWorkspaceStore((s) => s.setCrosshair);
  const setVisibleRange = useWorkspaceStore((s) => s.setVisibleRange);
  const setHoverSync = useWorkspaceStore((s) => s.setHoverSync);
  const jumpToTime = useWorkspaceStore((s) => s.visibleRange.jumpToTime);

  const pivotLookup = useMemo(() => {
    const map = new Map<string, { pivotType?: string | null; trendPivotType?: string | null }>();
    for (const pivot of overlay?.pivots ?? []) {
      map.set(pivot.barStartTs.slice(0, 10), { pivotType: pivot.pivotType, trendPivotType: pivot.trendPivotType });
    }
    return map;
  }, [overlay]);

  useEffect(() => {
    if (!ref.current) return;
    const chart = createChart(ref.current, {
      layout: { background: { color: '#0b1220' }, textColor: '#cbd5e1' },
      width: ref.current.clientWidth,
      height: 260,
      rightPriceScale: { visible: true },
      timeScale: { visible: true },
      grid: { vertLines: { color: '#1f2937' }, horzLines: { color: '#1f2937' } },
      crosshair: { mode: 1 },
    });
    chartRef.current = chart;

    const candleSeries = chart.addCandlestickSeries();
    const volumeSeries = chart.addHistogramSeries({ priceFormat: { type: 'volume' }, priceScaleId: '' });
    volumeSeries.priceScale().applyOptions({ scaleMargins: { top: 0.8, bottom: 0 } });

    const data: CandlestickData[] = (series?.candles ?? []).map((c) => ({
      time: c.barStartTs.slice(0, 10) as any, open: c.open, high: c.high, low: c.low, close: c.close,
    }));
    candleSeries.setData(data);
    const volumeData: HistogramData[] = (series?.candles ?? [])
      .filter((c) => c.volume != null)
      .map((c) => ({ time: c.barStartTs.slice(0, 10) as any, value: c.volume as number }));
    volumeSeries.setData(volumeData);

    const maybeAddLine = (points?: { time: string; value: number }[]) => {
      if (!points?.length) return;
      const line = chart.addLineSeries();
      line.setData(points.map((p) => ({ time: p.time.slice(0, 10) as any, value: p.value }) as LineData));
    };
    maybeAddLine(overlay?.sma?.sma5);
    maybeAddLine(overlay?.sma?.sma10);
    maybeAddLine(overlay?.sma?.sma20);

    syncManager?.register(chartKey, chart, candleSeries as any, (param: MouseEventParams<any>) => {
      const point = param.seriesData.get(candleSeries) as any;
      const time = typeof param.time === 'string' ? param.time : point?.time;
      if (!point || !time) return null;
      const pivot = pivotLookup.get(String(time));
      const state = {
        time: String(time),
        open: Number(point.open),
        high: Number(point.high),
        low: Number(point.low),
        close: Number(point.close),
        pivotType: pivot?.pivotType ?? null,
        trendPivotType: pivot?.trendPivotType ?? null,
      };
      setCrosshair({ source: chartKey, ...state });
      setHoverSync({ source: chartKey, time: String(time), price: Number(point.close) });
      return state;
    });

    const handleResize = () => {
      if (ref.current) chart.applyOptions({ width: ref.current.clientWidth });
    };
    const rangeUnsub = syncManager?.onVisibleRange((range) => setVisibleRange({ from: range.from, to: range.to }));
    const handleCrosshair = (param: MouseEventParams<any>) => {
      const point = param.seriesData.get(candleSeries) as any;
      const time = typeof param.time === 'string' ? param.time : point?.time;
      if (!point || !time) return;
      const pivot = pivotLookup.get(String(time));
      setCrosshair({
        source: chartKey,
        time: String(time),
        open: Number(point.open),
        high: Number(point.high),
        low: Number(point.low),
        close: Number(point.close),
        pivotType: pivot?.pivotType ?? null,
        trendPivotType: pivot?.trendPivotType ?? null,
      });
      setHoverSync({ source: chartKey, time: String(time), price: Number(point.close) });
    };
    chart.subscribeCrosshairMove(handleCrosshair);
    window.addEventListener('resize', handleResize);
    return () => {
      syncManager?.unregister(chartKey);
      rangeUnsub?.();
      chart.unsubscribeCrosshairMove(handleCrosshair);
      window.removeEventListener('resize', handleResize);
      chart.remove();
    };
  }, [chartKey, series, overlay, syncManager, pivotLookup, setCrosshair, setVisibleRange, setHoverSync]);

  useEffect(() => {
    if (!chartRef.current || !jumpToTime) return;
    const ts = chartRef.current.timeScale();
    const range = ts.getVisibleLogicalRange();
    const pos = (ts as any).timeToCoordinate?.(jumpToTime as any);
    if (!range || pos == null) return;
    const logical = ts.coordinateToLogical(pos);
    if (logical == null) return;
    const span = Math.max(20, range.to - range.from);
    ts.setVisibleLogicalRange({ from: logical - span / 2, to: logical + span / 2 });
  }, [jumpToTime]);

  return (
    <div style={{ border: '1px solid #243043', borderRadius: 8, padding: 8, background: '#111827' }}>
      <div style={{ marginBottom: 8, fontWeight: 700 }}>{title}</div>
      <div ref={ref} />
    </div>
  );
}
