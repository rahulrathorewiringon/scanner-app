import { useQuery } from "@tanstack/react-query";
import { apiClient } from "./apiClient";
import type { ChartRequestDto, MultiTimeframeChartsDto } from "../../types/chart.types";

export function useMultiTimeframeChartsQuery(request: ChartRequestDto) {
  const { instrumentId, ...params } = request;
  return useQuery({
    queryKey: ["multi-timeframe-charts", request],
    queryFn: () => apiClient.get<MultiTimeframeChartsDto>(`/api/instruments/${instrumentId}/charts`, { params }),
    staleTime: 15_000,
  });
}
