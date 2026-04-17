export interface RequestOptions {
  params?: Record<string, unknown>;
}

function buildUrl(path: string, params?: Record<string, unknown>): string {
  if (!params) return path;
  const url = new URL(path, "http://localhost");
  Object.entries(params).forEach(([key, value]) => {
    if (value === undefined || value === null) return;
    if (Array.isArray(value)) {
      value.forEach((item) => url.searchParams.append(key, String(item)));
    } else {
      url.searchParams.set(key, String(value));
    }
  });
  return url.pathname + url.search;
}

export const apiClient = {
  async get<T>(path: string, options?: RequestOptions): Promise<T> {
    const response = await fetch(buildUrl(path, options?.params));
    if (!response.ok) throw new Error(`GET ${path} failed`);
    return response.json() as Promise<T>;
  },
  async post<T>(path: string, body: unknown): Promise<T> {
    const response = await fetch(path, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    if (!response.ok) throw new Error(`POST ${path} failed`);
    return response.json() as Promise<T>;
  },
};
