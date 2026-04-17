# Remaining Phase 6 and Phase 7 implementation

This repo increment completes the platform and release-readiness work that remained after the workstation/domain features.

## Phase 6 completed
- Tauri desktop bridge and invoke commands
- desktop/web router split using `HashRouter` in desktop mode
- `DesktopBridge` with:
  - export file
  - save local config
  - load local config
  - notify
- updated `src-tauri` Rust files and config

## Phase 7 completed
- backend unit tests:
  - `ExchangeSchemaRegistryTest`
  - `SqlFragmentBuilderTest`
  - `AuthorizationServiceImplTest`
- frontend unit tests:
  - `DesktopBridge.test.ts`
  - `workspace.store.test.ts`
- CI workflows:
  - backend Maven test
  - frontend test + build
  - Tauri desktop build
- local dev bootstrap:
  - `docker-compose.dev.yml`
  - `scripts/dev/bootstrap-db.sql`
  - `scripts/dev/apply_readmodels.sh`

## Notes
- This increment improves readiness, but you still need to run Maven/Vite/Testcontainers locally.
- Tauri commands are implemented with safe minimal functionality for Phase 6.
