@echo off
echo Starting Stock Analysis Frontend...
echo ==================================

cd frontend

if "%1"=="install" (
    echo Installing dependencies...
    npm install
) else (
    echo Starting development server...
    npm run dev
)