# Stock Analysis Starter Repo

Monorepo starter with:
- `backend/` Spring Boot 3.3 + Java 21
- `frontend/` Vite + React + TypeScript + FlexLayout + Lightweight Charts
- `frontend/src-tauri/` minimal Tauri config scaffold

## Quick start

### Backend
```bash
cd backend
mvn spring-boot:run
```

### Frontend (browser)
```bash
cd frontend
npm install
npm run dev
```

### Frontend (desktop)
After installing Tauri prerequisites:
```bash
cd frontend
npm run tauri:dev
```
