import { useMutation, useQuery } from "@tanstack/react-query";
import { apiClient } from "./apiClient";
import type { ExchangeCode } from "../../types/common.types";
import type {
  ScreenerFilterMetadataDto,
  ScreenerRunRequestDto,
  ScreenerRunResponseDto,
} from "../../types/screener.types";

export function useScreenerFilterMetadataQuery(exchangeCode: ExchangeCode) {
  return useQuery({
    queryKey: ["screener-filter-metadata", exchangeCode],
    queryFn: () => apiClient.get<ScreenerFilterMetadataDto>("/api/screener/filter-metadata", { params: { exchangeCode } }),
    staleTime: 60_000,
  });
}

export function useScreenerCountMutation() {
  return useMutation({
    mutationFn: (request: ScreenerRunRequestDto) => apiClient.post<number>("/api/screener/count", request),
  });
}

export function useScreenerRunMutation() {
  return useMutation({
    mutationFn: (request: ScreenerRunRequestDto) => apiClient.post<ScreenerRunResponseDto>("/api/screener/run", request),
  });
}
