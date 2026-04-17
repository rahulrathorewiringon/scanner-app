import type { ExchangeCode } from './common.types';

export interface WorkspaceLayoutPreset {
  presetId: string;
  userId: string;
  name: string;
  exchangeCode: ExchangeCode;
  layoutJson: Record<string, unknown>;
  isDefault: boolean;
  isFavorite: boolean;
  createdAt: string;
  updatedAt: string;
}
export interface WorkspaceLayoutPresetShareDto {
  shareId: string;
  presetId: string;
  ownerUserId: string;
  sharedWithUserId: string;
  permission: 'VIEW' | 'EDIT';
  createdAt: string;
}
export interface SaveWorkspaceLayoutPresetRequestDto {
  userId: string;
  name: string;
  exchangeCode: ExchangeCode;
  layoutJson: Record<string, unknown>;
  isDefault?: boolean;
  isFavorite?: boolean;
}
export interface UpdateWorkspaceLayoutPresetRequestDto extends SaveWorkspaceLayoutPresetRequestDto {
  presetId: string;
}
