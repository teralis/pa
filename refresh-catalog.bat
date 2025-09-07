@echo off
REM CDN Catalog Refresh Script for Windows
REM Automatically scans repository and generates CDN_CATALOG.md

set BASE_URL=https://cdn.jsdelivr.net/gh/teralis/pa
set CATALOG_FILE=CDN_CATALOG.md

echo 🔄 Refreshing CDN Catalog...

REM Get current date
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set CURRENT_DATE=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%

REM Start building the catalog
(
echo # CDN URL Catalog
echo.
echo **Base URL:** `%BASE_URL%/`
echo.
echo Last updated: %CURRENT_DATE%
echo.
echo ---
echo.
echo ## 📁 Browse Directories
echo.
echo - **Root:** %BASE_URL%/
echo - **Assets ^(Tabler Icons^):** %BASE_URL%/assets/
echo - **QRTub Project:** %BASE_URL%/qrtub/
echo.
echo ---
echo.
echo ## 🎯 QRTub Project Files
echo.
echo ### Shared Icons
) > "%CATALOG_FILE%"

REM Scan qrtub directory for icons
if exist "qrtub\_shared\icons" (
    for %%f in ("qrtub\_shared\icons\*.*") do (
        echo - **%%~nxf**: %BASE_URL%/qrtub/_shared/icons/%%~nxf >> "%CATALOG_FILE%"
    )
)

(
echo.
echo ### Project Files
) >> "%CATALOG_FILE%"

REM Scan qrtub root files
if exist "qrtub" (
    for %%f in ("qrtub\*.*") do (
        echo - **%%~nxf**: %BASE_URL%/qrtub/%%~nxf >> "%CATALOG_FILE%"
    )
)

REM Check if Tabler icons exist and add section if they do
if exist "assets\icons_tabler" (
    (
    echo.
    echo ---
    echo.
    echo ## 📦 Tabler Icons Library
    echo.
    echo ### Browse Icons
    echo - **All Icons:** %BASE_URL%/assets/icons_tabler/
    ) >> "%CATALOG_FILE%"
    
    if exist "assets\icons_tabler\outline" (
        echo - **Outline Icons:** %BASE_URL%/assets/icons_tabler/outline/ >> "%CATALOG_FILE%"
    )
    
    if exist "assets\icons_tabler\filled" (
        echo - **Filled Icons:** %BASE_URL%/assets/icons_tabler/filled/ >> "%CATALOG_FILE%"
    )
    
    REM Add popular icons only if they exist
    if exist "assets\icons_tabler\outline\qrcode.svg" (
        (
        echo.
        echo ### Popular Icons for QR Apps
        echo.
        echo #### UI ^& Navigation
        echo - **menu-2.svg**: %BASE_URL%/assets/icons_tabler/outline/menu-2.svg
        echo - **x.svg**: %BASE_URL%/assets/icons_tabler/outline/x.svg
        echo - **home.svg**: %BASE_URL%/assets/icons_tabler/outline/home.svg
        echo - **settings.svg**: %BASE_URL%/assets/icons_tabler/outline/settings.svg
        echo.
        echo #### QR Code Related
        echo - **qrcode.svg**: %BASE_URL%/assets/icons_tabler/outline/qrcode.svg
        echo - **camera.svg**: %BASE_URL%/assets/icons_tabler/outline/camera.svg
        echo - **scan.svg**: %BASE_URL%/assets/icons_tabler/outline/scan.svg
        echo.
        echo #### Actions
        echo - **download.svg**: %BASE_URL%/assets/icons_tabler/outline/download.svg
        echo - **share.svg**: %BASE_URL%/assets/icons_tabler/outline/share.svg
        echo - **copy.svg**: %BASE_URL%/assets/icons_tabler/outline/copy.svg
        ) >> "%CATALOG_FILE%"
    )
)

REM Add other asset directories if they exist
if exist "assets" (
    (
    echo.
    echo ---
    echo.
    echo ## 📁 Other Assets
    ) >> "%CATALOG_FILE%"
    
    for /r "assets" %%f in (*.*) do (
        if not "%%~nxf"=="desktop.ini" (
            set "rel_path=%%f"
            setlocal enabledelayedexpansion
            set "rel_path=!rel_path:%CD%\=!"
            set "rel_path=!rel_path:\=/!"
            echo - **%%~nxf**: %BASE_URL%/!rel_path! >> "%CATALOG_FILE%"
            endlocal
        )
    )
)

REM Add remaining content
echo.
echo ---
echo.
echo ## 💡 Usage Examples
echo.
echo **HTML:**
echo ```html
echo ^<img src="%BASE_URL%/assets/icons_tabler/outline/qrcode.svg" 
echo      width="24" height="24" alt="QR Code"^>
echo ```
echo.
echo **CSS:**
echo ```css
echo .icon-qr {
echo   background: url^('%BASE_URL%/assets/icons_tabler/outline/qrcode.svg'^) no-repeat center;
echo   background-size: contain;
echo }
echo ```
echo.
echo ---
echo.
echo ## 🔄 Cache Information
echo.
echo - **Cache Time:** 7 days ^(automatic^)
echo - **Force Refresh:** Add `?v=timestamp` to URL
echo - **Purge Cache:** https://www.jsdelivr.com/tools/purge
echo.
echo ---
echo.
echo *🤖 This catalog is auto-generated. Run `refresh-catalog.bat` to update.*
) >> "%CATALOG_FILE%"

echo ✅ CDN Catalog refreshed successfully!
echo 📄 File: %CATALOG_FILE%
echo 📊 Catalog generated with current assets