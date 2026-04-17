@echo off
echo Stock Analysis Platform - Mock Database Test Runner
echo ===================================================
echo This script sets up the platform with an in-memory H2 database
echo for testing API and frontend functionality.
echo.

if "%1"=="help" (
    echo Usage:
    echo   run-tests.bat           - Start both backend and frontend
    echo   run-tests.bat backend    - Start only backend
    echo   run-tests.bat frontend   - Start only frontend
    echo   run-tests.bat setup      - Setup dependencies
    echo.
    echo The backend will run on http://localhost:8080 with H2 in-memory DB
    echo The frontend will run on http://localhost:5173
    echo.
    goto :eof
)

if "%1"=="setup" (
    echo Setting up dependencies...
    cd frontend
    npm install
    cd ..
    goto :eof
)

if "%1"=="backend" (
    echo Starting backend with mock database...
    call run-backend.bat test
    goto :eof
)

if "%1"=="frontend" (
    echo Starting frontend...
    call run-frontend.bat
    goto :eof
)

echo Starting both backend and frontend...
echo.

echo Backend will start with H2 in-memory database containing mock data for:
echo - 10 NSE instruments (RELIANCE, TCS, HDFC, etc.)
echo - Daily candle data for RELIANCE (last 30 days)
echo - Technical indicators (SMA, ATR, pivots)
echo - Sample saved screener, watchlist, alert, and workspace preset
echo.

start "Backend" cmd /c "run-backend.bat test"
timeout /t 10 /nobreak > nul
start "Frontend" cmd /c "run-frontend.bat"

echo.
echo Services started! Access the application at:
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:8080
echo.
echo Press Ctrl+C in the respective windows to stop services.