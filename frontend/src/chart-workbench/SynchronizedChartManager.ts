import type { IChartApi, ISeriesApi, LogicalRange, MouseEventParams } from 'lightweight-charts';
import type { CrosshairState } from '../stores/workspace.store';

type ChartKey = 'week' | 'day' | 'hour';
type CrosshairListener = (state: CrosshairState) => void;
type RangeListener = (range: LogicalRange) => void;

type RegisteredChart = {
  chart: IChartApi;
  primarySeries?: ISeriesApi<any>;
  getCrosshairState?: (param: MouseEventParams<any>) => CrosshairState | null;
};

export class SynchronizedChartManager {
  private charts = new Map<ChartKey, RegisteredChart>();
  private applyingRange = false;
  private applyingCrosshair = false;
  private rangeListeners = new Set<RangeListener>();
  private crosshairListeners = new Set<CrosshairListener>();

  register(
    key: ChartKey,
    chart: IChartApi,
    primarySeries?: ISeriesApi<any>,
    getCrosshairState?: (param: MouseEventParams<any>) => CrosshairState | null
  ) {
    this.charts.set(key, { chart, primarySeries, getCrosshairState });
    chart.timeScale().subscribeVisibleLogicalRangeChange((range) => {
      if (this.applyingRange || !range) return;
      this.broadcastRange(key, range);
      this.rangeListeners.forEach((listener) => listener(range));
    });
    chart.subscribeCrosshairMove((param) => {
      if (this.applyingCrosshair) return;
      const state = getCrosshairState?.(param);
      if (!state) return;
      this.crosshairListeners.forEach((listener) => listener({ source: key, ...state }));
      this.broadcastCrosshair(key, state);
    });
  }

  unregister(key: ChartKey) {
    this.charts.delete(key);
  }

  onVisibleRange(listener: RangeListener) {
    this.rangeListeners.add(listener);
    return () => this.rangeListeners.delete(listener);
  }

  onCrosshair(listener: CrosshairListener) {
    this.crosshairListeners.add(listener);
    return () => this.crosshairListeners.delete(listener);
  }

  private broadcastRange(source: ChartKey, range: LogicalRange) {
    this.applyingRange = true;
    try {
      this.charts.forEach(({ chart }, key) => {
        if (key === source) return;
        chart.timeScale().setVisibleLogicalRange(range);
      });
    } finally {
      this.applyingRange = false;
    }
  }

  private broadcastCrosshair(source: ChartKey, state: CrosshairState) {
    this.applyingCrosshair = true;
    try {
      this.charts.forEach(({ chart, primarySeries }, key) => {
        if (key === source) return;
        const chartAny = chart as any;
        if (typeof chartAny.setCrosshairPosition === 'function' && primarySeries && state.close != null && state.time) {
          chartAny.setCrosshairPosition(state.close, state.time, primarySeries);
        }
      });
    } finally {
      this.applyingCrosshair = false;
    }
  }

  clearCrosshair() {
    this.charts.forEach(({ chart }) => {
      const chartAny = chart as any;
      if (typeof chartAny.clearCrosshairPosition === 'function') {
        chartAny.clearCrosshairPosition();
      }
    });
  }

  fitContent() {
    this.charts.forEach(({ chart }) => chart.timeScale().fitContent());
  }

  jumpToTime(isoDate: string) {
    this.charts.forEach(({ chart }) => {
      const ts = chart.timeScale();
      const range = ts.getVisibleLogicalRange();
      if (!range) return;
      const span = Math.max(20, range.to - range.from);
      const pos = (ts as any).timeToCoordinate?.(isoDate as any);
      if (pos == null) return;
      const logical = ts.coordinateToLogical(pos);
      if (logical == null) return;
      ts.setVisibleLogicalRange({ from: logical - span / 2, to: logical + span / 2 });
    });
  }
}
