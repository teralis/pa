@echo off
REM Add new customer script for Windows
REM Usage: scripts\add-customer.bat "customer-name"

if "%1"=="" (
    echo Usage: %0 ^<customer-name^>
    echo Example: %0 "acme-corp"
    exit /b 1
)

set CUSTOMER_NAME=%1
set CUSTOMER_DIR=customers\%CUSTOMER_NAME%

echo Creating customer directory structure for: %CUSTOMER_NAME%

REM Create directories
mkdir "%CUSTOMER_DIR%\images" 2>nul
mkdir "%CUSTOMER_DIR%\docs" 2>nul

REM Create placeholder files
echo # %CUSTOMER_NAME% Assets > "%CUSTOMER_DIR%\README.md"
echo Upload your images here > "%CUSTOMER_DIR%\images\.gitkeep"
echo Upload your documents here > "%CUSTOMER_DIR%\docs\.gitkeep"

echo ✅ Customer structure created at: %CUSTOMER_DIR%
echo 📂 Upload files to:
echo    - Images: %CUSTOMER_DIR%\images\
echo    - Documents: %CUSTOMER_DIR%\docs\
echo.
echo 🔗 CDN URLs will be:
echo    - https://cdn.jsdelivr.net/gh/teralis/pa/%CUSTOMER_DIR%/images/filename.ext
echo    - https://cdn.jsdelivr.net/gh/teralis/pa/%CUSTOMER_DIR%/docs/filename.ext
echo.
echo 📁 Browse files at:
echo    - https://cdn.jsdelivr.net/gh/teralis/pa/%CUSTOMER_DIR%/