@echo off
echo Testing Mock Database Setup...
echo ===============================

cd backend

echo 1. Testing Maven compilation...
mvn clean compile -q
if %errorlevel% neq 0 (
    echo ERROR: Maven compilation failed
    goto :error
)
echo ✓ Compilation successful

echo.
echo 2. Testing Spring Boot context loading with test profile...
mvn test -Dtest=StockAnalysisBackendApplicationTests -q
if %errorlevel% neq 0 (
    echo ERROR: Spring Boot context test failed
    goto :error
)
echo ✓ Context loading successful

echo.
echo 3. All tests passed! Mock database setup is ready.
echo.
echo You can now run:
echo   run-tests.bat          - Start both services
echo   run-tests.bat backend   - Start backend only
echo   run-tests.bat frontend  - Start frontend only
echo.
goto :eof

:error
echo.
echo Setup validation failed. Please check the errors above.
pause