import { useQuery } from "@tanstack/react-query";
import { apiClient } from "./apiClient";
import type { InstrumentSearchRequestDto, InstrumentSearchResponseDto } from "../../types/instrument.types";

export function useInstrumentSearchQuery(request: InstrumentSearchRequestDto) {
  return useQuery({
    queryKey: ["instrument-search", request],
    queryFn: () => apiClient.post<InstrumentSearchResponseDto>("/api/analytics/instruments/search", request),
    staleTime: 15_000,
  });
}
