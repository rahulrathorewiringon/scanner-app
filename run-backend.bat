@echo off
echo Starting Stock Analysis Backend with Mock Database...
echo ===================================================

cd backend

if "%1"=="test" (
    echo Running with test profile (H2 in-memory database)
    mvn spring-boot:run -Dspring-boot.run.profiles=test
) else if "%1"=="local" (
    echo Running with local profile
    mvn spring-boot:run -Dspring-boot.run.profiles=local
) else (
    echo Running with default profile
    mvn spring-boot:run
)

echo Backend stopped.