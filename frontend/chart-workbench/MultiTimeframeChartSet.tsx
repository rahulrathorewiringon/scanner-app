import React from "react";
import { ChartPane } from "./ChartPane";

export function MultiTimeframeChartSet() {
  return (
    <div>
      <ChartPane timeframe="week" />
      <ChartPane timeframe="day" />
      <ChartPane timeframe="hour" />
    </div>
  );
}
