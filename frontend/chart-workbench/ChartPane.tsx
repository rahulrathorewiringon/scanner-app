import React from "react";
import type { Timeframe } from "../types/common.types";
// Locked decision: Lightweight Charts is the chart rendering library.
// import { createChart } from "lightweight-charts";

export function ChartPane({ timeframe }: { timeframe: Timeframe }) {
  return <div>{timeframe} chart pane</div>;
}
