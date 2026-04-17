import { create } from 'zustand';
import type { ExchangeCode, Timeframe, TrendState } from '../types/common.types';
import type { PivotTimelineEvent } from '../types/chart.types';

export type VisibleRange = { from?: number; to?: number; jumpToTime?: string | null };
export type CrosshairState = { source?: string | null; time?: string | null; open?: number | null; high?: number | null; low?: number | null; close?: number | null; pivotType?: string | null; trendPivotType?: string | null; };
export type HoverSyncState = { source?: string | null; time?: string | null; price?: number | null; };

interface WorkspaceState {
  userId: string;
  exchangeCode: ExchangeCode;
  tradeDate: string;
  activeInstrumentId: number;
  symbolQuery: string;
  trendFilter: 'ALL' | TrendState;
  selectedTimeframes: Timeframe[];
  syncEnabled: boolean;
  visibleRange: VisibleRange;
  crosshair: CrosshairState;
  hoverSync: HoverSyncState;
  workspaceModelJson?: string | null;
  pivotTimeline: PivotTimelineEvent[];
  markerLegend: Array<{ label: string; description: string }>;
  setUserId: (value: string) => void;
  setExchangeCode: (value: ExchangeCode) => void;
  setTradeDate: (value: string) => void;
  setActiveInstrumentId: (value: number) => void;
  setSymbolQuery: (value: string) => void;
  setTrendFilter: (value: 'ALL' | TrendState) => void;
  setSelectedTimeframes: (value: Timeframe[]) => void;
  setSyncEnabled: (value: boolean) => void;
  setVisibleRange: (value: VisibleRange) => void;
  setCrosshair: (value: CrosshairState) => void;
  setHoverSync: (value: HoverSyncState) => void;
  setWorkspaceModelJson: (value: string) => void;
  setPivotTimeline: (value: PivotTimelineEvent[]) => void;
  setMarkerLegend: (value: Array<{ label: string; description: string }>) => void;
}

export const useWorkspaceStore = create<WorkspaceState>((set) => ({
  userId: 'demo-user', exchangeCode: 'NSE', tradeDate: '2026-04-17', activeInstrumentId: 1, symbolQuery: '', trendFilter: 'ALL', selectedTimeframes: ['week','day','hour'], syncEnabled: true, visibleRange: {}, crosshair: {}, hoverSync: {}, workspaceModelJson: null, pivotTimeline: [], markerLegend: [],
  setUserId: (userId) => set({ userId }), setExchangeCode: (exchangeCode) => set({ exchangeCode }), setTradeDate: (tradeDate) => set({ tradeDate }), setActiveInstrumentId: (activeInstrumentId) => set({ activeInstrumentId }), setSymbolQuery: (symbolQuery) => set({ symbolQuery }), setTrendFilter: (trendFilter) => set({ trendFilter }), setSelectedTimeframes: (selectedTimeframes) => set({ selectedTimeframes }), setSyncEnabled: (syncEnabled) => set({ syncEnabled }), setVisibleRange: (visibleRange) => set({ visibleRange }), setCrosshair: (crosshair) => set({ crosshair }), setHoverSync: (hoverSync) => set({ hoverSync }), setWorkspaceModelJson: (workspaceModelJson) => set({ workspaceModelJson }), setPivotTimeline: (pivotTimeline) => set({ pivotTimeline }), setMarkerLegend: (markerLegend) => set({ markerLegend }),
}));
