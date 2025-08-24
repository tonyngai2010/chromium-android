@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: apply_patch.bat patch_file.patch
    exit /b 1
)

set PATCH_FILE=%~1
set TIMESTAMP=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%
set BACKUP_DIR=backup\%TIMESTAMP%

echo [INFO] Applying patch: %PATCH_FILE%
echo [INFO] Backup directory: %BACKUP_DIR%

:: Create backup directory
mkdir "%BACKUP_DIR%" 2>nul

:: Enter src directory
cd src

:: Apply patch and capture affected files
echo [INFO] Applying patch...
git apply --check "..\patches\%PATCH_FILE%" 2>nul
if errorlevel 1 (
    echo [ERROR] Patch validation failed
    cd ..
    exit /b 1
)

:: Get list of files that will be modified
for /f "tokens=*" %%i in ('git apply --numstat "..\patches\%PATCH_FILE%" 2^>nul ^| findstr /v "^$"') do (
    for /f "tokens=3" %%j in ("%%i") do (
        set FILE_PATH=%%j
        echo [INFO] Backing up: !FILE_PATH!
        
        :: Create directory structure in backup
        for %%k in ("!FILE_PATH!") do (
            set DIR_PATH=%%~dpk
            mkdir "..\%BACKUP_DIR%\!DIR_PATH!" 2>nul
        )
        
        :: Backup original file if exists
        if exist "!FILE_PATH!" (
            copy "!FILE_PATH!" "..\%BACKUP_DIR%\!FILE_PATH!" >nul
        ) else (
            :: If file doesn't exist, try to get it from remote
            echo [INFO] File !FILE_PATH! not found locally, fetching from remote...
            git show origin/main:!FILE_PATH! > "!FILE_PATH!" 2>nul
            if errorlevel 1 (
                echo [WARNING] Could not fetch !FILE_PATH! from remote
            ) else (
                copy "!FILE_PATH!" "..\%BACKUP_DIR%\!FILE_PATH!" >nul
            )
        )
    )
)

:: Apply the patch
git apply "..\patches\%PATCH_FILE%"
if errorlevel 1 (
    echo [ERROR] Failed to apply patch
    cd ..
    exit /b 1
)

:: Record applied patch
echo %PATCH_FILE%:%TIMESTAMP% >> "..\applied_patches\applied.log"

echo [SUCCESS] Patch applied successfully
echo [INFO] Backup saved to: %BACKUP_DIR%

cd ..