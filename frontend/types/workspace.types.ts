export type WorkspaceTabKind =
  | "dashboard"
  | "instruments"
  | "screener"
  | "instrument-summary"
  | "multi-timeframe-chart"
  | "pivot-chart"
  | "rule-explanation"
  | "alert-timeline"
  | "snapshot-inspector";

export interface WorkspaceTabDescriptor {
  id: string;
  kind: WorkspaceTabKind;
  title: string;
  payload?: Record<string, unknown>;
}
