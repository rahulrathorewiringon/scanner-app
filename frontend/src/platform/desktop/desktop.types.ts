export interface DesktopConfigRecord {
  [key: string]: unknown;
}

export interface ExportTextFileRequest {
  defaultFileName: string;
  contents: string;
}

export interface DesktopNotificationRequest {
  title: string;
  body: string;
}
