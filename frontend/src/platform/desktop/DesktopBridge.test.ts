import { DesktopBridge } from './DesktopBridge';

describe('DesktopBridge web fallback', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('saves and loads config using localStorage when not in desktop mode', async () => {
    expect(DesktopBridge.isDesktop()).toBe(false);
    await DesktopBridge.saveLocalConfig({ theme: 'dark', grid: true });
    const loaded = await DesktopBridge.loadLocalConfig<{ theme: string; grid: boolean }>();
    expect(loaded).toEqual({ theme: 'dark', grid: true });
  });
});
