import { invoke } from '@tauri-apps/api/core';
import type { DesktopConfigRecord, DesktopNotificationRequest, ExportTextFileRequest } from './desktop.types';

declare global {
  interface Window {
    __TAURI__?: unknown;
    __TAURI_INTERNALS__?: unknown;
  }
}

const CONFIG_KEY = 'stockanalysis:desktop-config';

export const DesktopBridge = {
  isDesktop(): boolean {
    return typeof window !== 'undefined' && (!!window.__TAURI__ || !!window.__TAURI_INTERNALS__);
  },

  async exportTextFile(request: ExportTextFileRequest): Promise<{ success: boolean; path?: string | null }> {
    if (this.isDesktop()) {
      return invoke('export_text_file', { request });
    }
    const blob = new Blob([request.contents], { type: 'text/plain;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const anchor = document.createElement('a');
    anchor.href = url;
    anchor.download = request.defaultFileName;
    anchor.click();
    URL.revokeObjectURL(url);
    return { success: true, path: null };
  },

  async saveLocalConfig(config: DesktopConfigRecord): Promise<void> {
    if (this.isDesktop()) {
      await invoke('save_local_config', { config });
      return;
    }
    localStorage.setItem(CONFIG_KEY, JSON.stringify(config));
  },

  async loadLocalConfig<T extends DesktopConfigRecord>(): Promise<T | null> {
    if (this.isDesktop()) {
      return invoke('load_local_config');
    }
    const raw = localStorage.getItem(CONFIG_KEY);
    return raw ? JSON.parse(raw) as T : null;
  },

  async notify(request: DesktopNotificationRequest): Promise<void> {
    if (this.isDesktop()) {
      await invoke('notify_user', { request });
      return;
    }
    if (typeof window !== 'undefined' && 'Notification' in window) {
      if (Notification.permission === 'granted') {
        new Notification(request.title, { body: request.body });
      }
    }
  },
};
