@echo off
setlocal
title Blood Bowl 2 - World Languages Uninstaller

set "GAMEDIR=%~dp0..\"
if not exist "%GAMEDIR%BloodBowl2.exe" goto :NOGAME
if not exist "%~dp0backup\Default_loc_English.db" goto :NOBACKUP

copy /y "%~dp0backup\Default_loc_English.db" "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" >nul
if errorlevel 1 goto :RESTOREFAIL
echo [OK] Original English language file restored

for %%F in (
  "Gui\Fonts\fonts.xml"
  "Gui\Fonts\FontBB2_TRUMP_TOWN_PRO.TTF"
  "Gui\Fonts\english\FontBB2_TRUMP_TOWN_PRO.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-REGULAR.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-REGULAR.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-SEMIBOLD.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-SEMIBOLD.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-ITALIC.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-ITALIC.TTF"
  "Gui\Fonts\FontBB2_OPENSANS-BOLDITALIC.TTF"
  "Gui\Fonts\english\FontBB2_OPENSANS-BOLDITALIC.TTF"
  "Gui\Fonts\FontBB2_ROBOTOCONDENSED-BOLD.TTF"
  "Gui\Fonts\english\FontBB2_ROBOTOCONDENSED-BOLD.TTF"
  "Gui\Fonts\FontBB2_KELLYSLAB-REGULAR.TTF"
  "Gui\Fonts\english\FontBB2_KELLYSLAB-REGULAR.TTF"
  "Gui\Fonts\FontBB2_LOBSTER.TTF"
  "Gui\Fonts\english\FontBB2_LOBSTER.TTF"
  "Gui\Fonts\FontBB2_COURIERNEW.TTF"
  "Gui\Fonts\english\FontBB2_COURIERNEW.TTF"
) do (
  if exist "%GAMEDIR%Data\%%~F" del /f /q "%GAMEDIR%Data\%%~F"
)
dir /b "%GAMEDIR%Data\Gui\Fonts\english" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui\Fonts\english" 2>nul
dir /b "%GAMEDIR%Data\Gui\Fonts" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui\Fonts" 2>nul
dir /b "%GAMEDIR%Data\Gui" 2>nul | findstr . >nul || rd "%GAMEDIR%Data\Gui" 2>nul
echo [OK] Mod files cleaned
echo.
echo Uninstall complete - game restored to original English.
pause
exit /b 0

:NOGAME
echo [ERROR] Game not found. Keep BB2WorldLang inside the game root folder.
pause
exit /b 1
:NOBACKUP
echo [ERROR] Backup file backup\Default_loc_English.db not found.
pause
exit /b 1
:RESTOREFAIL
echo [ERROR] Failed to restore language file.
pause
exit /b 1
