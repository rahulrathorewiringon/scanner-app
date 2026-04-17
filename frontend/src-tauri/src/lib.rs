use serde::{Deserialize, Serialize};
use std::{fs, path::PathBuf};

#[derive(Serialize, Deserialize)]
pub struct ExportTextFileRequest {
    pub default_file_name: String,
    pub contents: String,
}

#[derive(Serialize, Deserialize)]
pub struct NotifyRequest {
    pub title: String,
    pub body: String,
}

fn app_data_file(name: &str) -> Result<PathBuf, String> {
    let mut path = tauri::api::path::app_data_dir(&tauri::Config::default())
        .ok_or("Unable to resolve app data directory")?;
    fs::create_dir_all(&path).map_err(|e| e.to_string())?;
    path.push(name);
    Ok(path)
}

#[tauri::command]
pub fn export_text_file(request: ExportTextFileRequest) -> Result<serde_json::Value, String> {
    let mut path = app_data_file(&request.default_file_name)?;
    if path.file_name().is_none() {
        path.push(&request.default_file_name);
    }
    fs::write(&path, request.contents).map_err(|e| e.to_string())?;
    Ok(serde_json::json!({ "success": true, "path": path.to_string_lossy() }))
}

#[tauri::command]
pub fn save_local_config(config: serde_json::Value) -> Result<(), String> {
    let path = app_data_file("desktop-config.json")?;
    fs::write(path, serde_json::to_vec_pretty(&config).map_err(|e| e.to_string())?).map_err(|e| e.to_string())
}

#[tauri::command]
pub fn load_local_config() -> Result<Option<serde_json::Value>, String> {
    let path = app_data_file("desktop-config.json")?;
    if !path.exists() {
        return Ok(None);
    }
    let data = fs::read(path).map_err(|e| e.to_string())?;
    let value = serde_json::from_slice(&data).map_err(|e| e.to_string())?;
    Ok(Some(value))
}

#[tauri::command]
pub fn notify_user(_request: NotifyRequest) -> Result<(), String> {
    Ok(())
}
