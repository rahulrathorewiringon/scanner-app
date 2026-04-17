export const apiClient = {
  async get<T>(url: string, options?: { params?: Record<string, unknown> }): Promise<T> {
    void options;
    throw new Error(`Implement GET ${url}`);
  },
  async post<T>(url: string, body?: unknown): Promise<T> {
    void body;
    throw new Error(`Implement POST ${url}`);
  },
};
