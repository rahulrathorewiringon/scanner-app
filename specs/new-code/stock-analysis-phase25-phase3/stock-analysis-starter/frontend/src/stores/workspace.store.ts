import { create } from 'zustand';
import type { ExchangeCode } from '../types/common.types';
import type { TrendState } from '../types/common.types';

interface WorkspaceState {
  exchangeCode: ExchangeCode;
  tradeDate: string;
  activeInstrumentId: number;
  symbolQuery: string;
  trendFilter: 'ALL' | TrendState;
  setExchangeCode: (value: ExchangeCode) => void;
  setTradeDate: (value: string) => void;
  setActiveInstrumentId: (value: number) => void;
  setSymbolQuery: (value: string) => void;
  setTrendFilter: (value: 'ALL' | TrendState) => void;
}

export const useWorkspaceStore = create<WorkspaceState>((set) => ({
  exchangeCode: 'NSE',
  tradeDate: '2026-04-17',
  activeInstrumentId: 1,
  symbolQuery: '',
  trendFilter: 'ALL',
  setExchangeCode: (exchangeCode) => set({ exchangeCode }),
  setTradeDate: (tradeDate) => set({ tradeDate }),
  setActiveInstrumentId: (activeInstrumentId) => set({ activeInstrumentId }),
  setSymbolQuery: (symbolQuery) => set({ symbolQuery }),
  setTrendFilter: (trendFilter) => set({ trendFilter }),
}));
