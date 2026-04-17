#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use stock_analysis_workstation_lib::{export_text_file, load_local_config, notify_user, save_local_config};

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            export_text_file,
            save_local_config,
            load_local_config,
            notify_user
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
