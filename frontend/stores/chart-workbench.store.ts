export interface ChartWorkbenchState {
  activeInstrumentId: number | null;
  selectedPivotId: string | null;
  syncCrosshair: boolean;
  syncVisibleRange: boolean;
}
