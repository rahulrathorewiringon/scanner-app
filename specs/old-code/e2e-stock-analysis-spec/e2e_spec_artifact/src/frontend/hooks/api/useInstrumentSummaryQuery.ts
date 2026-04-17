import { useQuery } from "@tanstack/react-query";
import { apiClient } from "./apiClient";
import type { InstrumentSummaryDto } from "../../types/instrument.types";
import type { ExchangeCode } from "../../types/common.types";

export function useInstrumentSummaryQuery(params: {
  exchangeCode: ExchangeCode;
  instrumentId: number;
  tradeDate: string;
}) {
  const { instrumentId, ...rest } = params;
  return useQuery({
    queryKey: ["instrument-summary", params],
    queryFn: () => apiClient.get<InstrumentSummaryDto>(`/api/instruments/${instrumentId}/summary`, { params: rest }),
    staleTime: 15_000,
  });
}
