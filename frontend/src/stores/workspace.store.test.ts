import { useWorkspaceStore } from './workspace.store';

describe('workspace store', () => {
  it('updates visible range', () => {
    useWorkspaceStore.getState().setVisibleRange({ from: 10, to: 20 });
    expect(useWorkspaceStore.getState().visibleRange).toEqual({ from: 10, to: 20 });
  });

  it('updates crosshair state', () => {
    useWorkspaceStore.getState().setCrosshair({ source: 'day', time: '2026-04-17', close: 100 });
    expect(useWorkspaceStore.getState().crosshair.close).toBe(100);
  });
});
