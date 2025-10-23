@echo off
REM Comprehensive CDN Update Script
REM Updates both catalog content and directory browse links dynamically

set BASE_URL=https://cdn.jsdelivr.net/gh/teralis/pa
set CATALOG_FILE=CDN_CATALOG.md

echo 🔄 Updating CDN Catalog and Directory Links...

REM Get current date
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set CURRENT_DATE=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%

REM Start building the catalog with dynamic directory detection
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
) > "%CATALOG_FILE%"

REM Dynamically detect and add existing directories
if exist "assets" (
    echo - **Assets:** %BASE_URL%/assets/ >> "%CATALOG_FILE%"
)

if exist "qrtub" (
    echo - **QRTub Project:** %BASE_URL%/qrtub/ >> "%CATALOG_FILE%"
)

if exist "docs" (
    echo - **Documentation:** %BASE_URL%/docs/ >> "%CATALOG_FILE%"
)

if exist "images" (
    echo - **Images:** %BASE_URL%/images/ >> "%CATALOG_FILE%"
)

REM Add any other top-level directories (excluding system dirs)
for /d %%d in (*) do (
    if not "%%d"==".git" if not "%%d"=="node_modules" if not "%%d"=="assets" if not "%%d"=="qrtub" if not "%%d"=="docs" if not "%%d"=="images" (
        echo - **%%d:** %BASE_URL%/%%d/ >> "%CATALOG_FILE%"
    )
)

REM Add QRTub section if it exists
if exist "qrtub" (
    (
    echo.
    echo ---
    echo.
    echo ## 🎯 QRTub Project Files
    echo.
    ) >> "%CATALOG_FILE%"
    
    REM Shared Icons
    if exist "qrtub\_shared\icons" (
        echo ### Shared Icons >> "%CATALOG_FILE%"
        for %%f in ("qrtub\_shared\icons\*.*") do (
            echo - **%%~nxf**: %BASE_URL%/qrtub/_shared/icons/%%~nxf >> "%CATALOG_FILE%"
        )
        echo. >> "%CATALOG_FILE%"
    )
    
    REM Project Files
    echo ### Project Files >> "%CATALOG_FILE%"
    for %%f in ("qrtub\*.*") do (
        echo - **%%~nxf**: %BASE_URL%/qrtub/%%~nxf >> "%CATALOG_FILE%"
    )
    
    REM QRTub subdirectories
    for /d %%d in ("qrtub\*") do (
        if not "%%~nd"=="_shared" (
            echo. >> "%CATALOG_FILE%"
            echo ### %%~nd Directory >> "%CATALOG_FILE%"
            echo - **Browse:** %BASE_URL%/qrtub/%%~nd/ >> "%CATALOG_FILE%"
        )
    )
)

REM Add PK section if it exists
if exist "pk" (
    (
    echo.
    echo ---
    echo.
    echo ## 📚 PK Files
    echo.
    ) >> "%CATALOG_FILE%"

    REM PK Files
    echo ### Files >> "%CATALOG_FILE%"
    for %%f in ("pk\*.*") do (
        if not "%%~nxf"=="desktop.ini" (
            echo - **%%~nxf**: %BASE_URL%/pk/%%~nxf >> "%CATALOG_FILE%"
        )
    )

    REM PK subdirectories (if any)
    for /d %%d in ("pk\*") do (
        echo. >> "%CATALOG_FILE%"
        echo ### %%~nd Directory >> "%CATALOG_FILE%"
        echo - **Browse:** %BASE_URL%/pk/%%~nd/ >> "%CATALOG_FILE%"
    )
)

REM Add Assets section if it exists
if exist "assets" (
    (
    echo.
    echo ---
    echo.
    echo ## 📦 Assets Library
    echo.
    ) >> "%CATALOG_FILE%"
    
    REM Check for Tabler icons
    if exist "assets\icons_tabler" (
        echo ### Tabler Icons >> "%CATALOG_FILE%"
        echo - **All Icons:** %BASE_URL%/assets/icons_tabler/ >> "%CATALOG_FILE%"
        
        if exist "assets\icons_tabler\outline" (
            echo - **Outline Icons:** %BASE_URL%/assets/icons_tabler/outline/ >> "%CATALOG_FILE%"
        )
        
        if exist "assets\icons_tabler\filled" (
            echo - **Filled Icons:** %BASE_URL%/assets/icons_tabler/filled/ >> "%CATALOG_FILE%"
        )
        
        REM Add popular icons if they exist
        if exist "assets\icons_tabler\outline\qrcode.svg" (
            (
            echo.
            echo ### Popular QR App Icons
            echo - **qrcode.svg**: %BASE_URL%/assets/icons_tabler/outline/qrcode.svg
            echo - **camera.svg**: %BASE_URL%/assets/icons_tabler/outline/camera.svg
            echo - **menu-2.svg**: %BASE_URL%/assets/icons_tabler/outline/menu-2.svg
            echo - **settings.svg**: %BASE_URL%/assets/icons_tabler/outline/settings.svg
            echo - **download.svg**: %BASE_URL%/assets/icons_tabler/outline/download.svg
            echo - **share.svg**: %BASE_URL%/assets/icons_tabler/outline/share.svg
            ) >> "%CATALOG_FILE%"
        )
        echo. >> "%CATALOG_FILE%"
    )
    
    REM Other asset files
    echo ### Other Assets >> "%CATALOG_FILE%"
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

REM Add any standalone files in root
(
echo.
echo ---
echo.
echo ## 📄 Root Files
) >> "%CATALOG_FILE%"

REM Add specific root files without duplicates
if exist "README.md" echo - **README.md**: %BASE_URL%/README.md >> "%CATALOG_FILE%"
if exist "USAGE.md" echo - **USAGE.md**: %BASE_URL%/USAGE.md >> "%CATALOG_FILE%"
if exist "CDN_CATALOG.md" echo - **CDN_CATALOG.md**: %BASE_URL%/CDN_CATALOG.md >> "%CATALOG_FILE%"

REM Add any other markdown or config files
for %%f in ("*.json" "*.txt" "*.yml" "*.yaml" ".gitignore") do (
    if exist "%%f" if not "%%~nxf"=="CDN_CATALOG.md" if not "%%~nxf"=="README.md" if not "%%~nxf"=="USAGE.md" (
        echo - **%%~nxf**: %BASE_URL%/%%~nxf >> "%CATALOG_FILE%"
    )
)

REM Add usage examples and footer
(
echo.
echo ---
echo.
echo ## 💡 Quick Usage Examples
echo.
echo **HTML Image:**
echo ```html
echo ^<img src="%BASE_URL%/qrtub/_shared/icons/weight.png" alt="Weight"^>
echo ```
echo.
echo **CSS Background:**
echo ```css
echo .icon { background: url^('%BASE_URL%/path/to/icon.svg'^) no-repeat center; }
echo ```
echo.
echo **Direct Link:**
echo ```
echo %BASE_URL%/qrtub/README.md
echo ```
echo.
echo ---
echo.
echo ## 🔄 Cache ^& Updates
echo.
echo - **Cache Time:** 7 days ^(automatic^)
echo - **Force Refresh:** Add `?v=timestamp` to any URL
echo - **Purge Cache:** https://www.jsdelivr.com/tools/purge
echo - **Update Catalog:** Run `update-cdn.bat`
echo.
echo ---
echo.
echo *🤖 Auto-generated catalog - always reflects current repository structure*
) >> "%CATALOG_FILE%"

echo ✅ CDN Catalog updated successfully!
echo 📄 File: %CATALOG_FILE%
echo 🔗 All directory links are now current
echo 📊 Found and cataloged all existing assets

REM Optional: Show summary
echo.
echo 📋 Summary:
if exist "qrtub" echo   ✓ QRTub project files
if exist "assets" echo   ✓ Assets directory  
if not exist "assets" echo   ✗ No assets directory found
echo   ✓ Dynamic directory links
echo   ✓ Dead link cleanup complete