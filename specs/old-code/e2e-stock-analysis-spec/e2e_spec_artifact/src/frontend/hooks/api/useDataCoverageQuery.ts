import { useQuery } from "@tanstack/react-query";
import { apiClient } from "./apiClient";
import type { DataCoverageDto } from "../../types/dashboard.types";
import type { ExchangeCode } from "../../types/common.types";

export function useDataCoverageQuery(exchangeCode: ExchangeCode) {
  return useQuery({
    queryKey: ["data-coverage", exchangeCode],
    queryFn: () => apiClient.get<DataCoverageDto>("/api/analytics/data-coverage", { params: { exchangeCode } }),
    staleTime: 30_000,
  });
}
