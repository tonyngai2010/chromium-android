@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: rollback_patch.bat backup_timestamp
    echo Available backups:
    dir /b backup
    exit /b 1
)

set BACKUP_TIMESTAMP=%~1
set BACKUP_DIR=backup\%BACKUP_TIMESTAMP%

if not exist "%BACKUP_DIR%" (
    echo [ERROR] Backup directory not found: %BACKUP_DIR%
    exit /b 1
)

echo [INFO] Rolling back from backup: %BACKUP_DIR%

:: Restore files from backup
xcopy "%BACKUP_DIR%\*" "src\" /s /e /y >nul

echo [SUCCESS] Rollback completed