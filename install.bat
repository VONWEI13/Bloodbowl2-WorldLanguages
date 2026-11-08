@echo off
setlocal
title Blood Bowl 2 - World Languages Installer

set "LANGCODE=%~1"
if not defined LANGCODE goto :MENU
goto :RESOLVE

:MENU
cls
echo ============================================
echo   Blood Bowl 2 - World Languages Installer
echo ============================================
echo.
echo   1. Simplified Chinese
echo   2. Traditional Chinese
echo   3. Japanese
echo   4. Portugues (Brasil)
echo   5. Turkce
echo.
choice /c 12345 /n /m "Select language [1-5]: "
set "MENUCHOICE=%errorlevel%"
if "%MENUCHOICE%"=="1" set "LANGCODE=zhhans"
if "%MENUCHOICE%"=="2" set "LANGCODE=zhhant"
if "%MENUCHOICE%"=="3" set "LANGCODE=ja"
if "%MENUCHOICE%"=="4" set "LANGCODE=ptbr"
if "%MENUCHOICE%"=="5" set "LANGCODE=tr"

:RESOLVE
if /i "%LANGCODE%"=="zhhans" (
  set "LANGNAME=Simplified Chinese"
  set "NEEDFONT=1"
  goto :CONFIGURED
)
if /i "%LANGCODE%"=="zhhant" (
  set "LANGNAME=Traditional Chinese"
  set "NEEDFONT=1"
  goto :CONFIGURED
)
if /i "%LANGCODE%"=="ja" (
  set "LANGNAME=Japanese"
  set "NEEDFONT=1"
  goto :CONFIGURED
)
if /i "%LANGCODE%"=="ptbr" (
  set "LANGNAME=Portugues (Brasil)"
  goto :CONFIGURED
)
if /i "%LANGCODE%"=="tr" (
  set "LANGNAME=Turkce"
  goto :CONFIGURED
)
echo [ERROR] Unknown language code: %LANGCODE%
echo Supported codes: zhhans, zhhant, ja, ptbr, tr
pause
exit /b 1

:CONFIGURED
title Blood Bowl 2 - %LANGNAME% Localization Installer
set "GAMEDIR=%~dp0..\"
set "LANGDIR=%~dp0%LANGCODE%\"
set "SOURCE_DB=%LANGDIR%files\Data\DBToolDB\Localization\Default_loc_English.db"
set "FONT=%LANGDIR%ChineseFont.ttf"

if not exist "%GAMEDIR%BloodBowl2.exe" goto :NOGAME
if not exist "%SOURCE_DB%" goto :NOSOURCE
if not exist "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" goto :NOENGLISH
if not defined NEEDFONT goto :SOURCESOK
if not exist "%FONT%" goto :FONTMISSING
if not exist "%LANGDIR%files\Data\Gui\Fonts\fonts.xml" goto :XMLMISSING

:SOURCESOK
if exist "%~dp0backup\Default_loc_English.db" goto :HAVEBACKUP
mkdir "%~dp0backup" 2>nul
copy /y "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" "%~dp0backup\" >nul 2>&1
if errorlevel 1 goto :BACKUPFAIL
echo [1/3] Original English language file backed up to backup\
goto :DEPLOY

:HAVEBACKUP
echo [1/3] Existing backup found, skipping backup

:DEPLOY
if not exist "%GAMEDIR%Data\Gui\Fonts\fonts.xml" goto :CLEANFONTS
del /f /q "%GAMEDIR%Data\Gui\Fonts\fonts.xml" >nul 2>&1
if exist "%GAMEDIR%Data\Gui\Fonts\fonts.xml" goto :CLEANFAIL

:CLEANFONTS
for %%F in (
  FontBB2_TRUMP_TOWN_PRO
  FontBB2_OPENSANS-REGULAR
  FontBB2_OPENSANS-SEMIBOLD
  FontBB2_OPENSANS-ITALIC
  FontBB2_OPENSANS-BOLDITALIC
  FontBB2_ROBOTOCONDENSED-BOLD
  FontBB2_KELLYSLAB-REGULAR
  FontBB2_LOBSTER
  FontBB2_COURIERNEW
) do (
  if exist "%GAMEDIR%Data\Gui\Fonts\%%F.TTF" del /f /q "%GAMEDIR%Data\Gui\Fonts\%%F.TTF" >nul 2>&1
  if exist "%GAMEDIR%Data\Gui\Fonts\%%F.TTF" goto :CLEANFAIL
  if exist "%GAMEDIR%Data\Gui\Fonts\english\%%F.TTF" del /f /q "%GAMEDIR%Data\Gui\Fonts\english\%%F.TTF" >nul 2>&1
  if exist "%GAMEDIR%Data\Gui\Fonts\english\%%F.TTF" goto :CLEANFAIL
)

xcopy /y /e /i "%LANGDIR%files\Data\*" "%GAMEDIR%Data\" >nul
if errorlevel 1 goto :COPYFAIL
fc /b "%SOURCE_DB%" "%GAMEDIR%Data\DBToolDB\Localization\Default_loc_English.db" >nul
if errorlevel 1 goto :VERIFYFAIL
echo [2/3] %LANGNAME% language files deployed

if not defined NEEDFONT goto :NOFONT
mkdir "%GAMEDIR%Data\Gui\Fonts\english" 2>nul
for %%F in (
  FontBB2_TRUMP_TOWN_PRO
  FontBB2_OPENSANS-REGULAR
  FontBB2_OPENSANS-SEMIBOLD
  FontBB2_OPENSANS-ITALIC
  FontBB2_OPENSANS-BOLDITALIC
  FontBB2_ROBOTOCONDENSED-BOLD
  FontBB2_KELLYSLAB-REGULAR
  FontBB2_LOBSTER
  FontBB2_COURIERNEW
) do (
  copy /y "%FONT%" "%GAMEDIR%Data\Gui\Fonts\%%F.TTF" >nul
  if errorlevel 1 goto :COPYFAIL
  copy /y "%FONT%" "%GAMEDIR%Data\Gui\Fonts\english\%%F.TTF" >nul
  if errorlevel 1 goto :COPYFAIL
)
fc /b "%FONT%" "%GAMEDIR%Data\Gui\Fonts\FontBB2_OPENSANS-REGULAR.TTF" >nul
if errorlevel 1 goto :VERIFYFAIL
fc /b "%FONT%" "%GAMEDIR%Data\Gui\Fonts\english\FontBB2_OPENSANS-REGULAR.TTF" >nul
if errorlevel 1 goto :VERIFYFAIL
echo [3/3] CJK font deployed
goto :DONE

:NOFONT
echo [3/3] No custom font needed for this language

:DONE
echo.
echo ============================================
echo   Done! Launch the game (language = English)
echo   to play in %LANGNAME%.
echo   To remove: run uninstall.bat
echo ============================================
pause
exit /b 0

:NOGAME
echo [ERROR] BloodBowl2.exe not found.
echo Put the whole BB2WorldLang folder into the game root folder
echo (the folder that contains BloodBowl2.exe) and run again.
pause
exit /b 1

:NOSOURCE
echo [ERROR] Language database not found:
echo %SOURCE_DB%
pause
exit /b 1

:NOENGLISH
echo [ERROR] Game language database not found.
echo Verify the game files and try again.
pause
exit /b 1

:FONTMISSING
echo [ERROR] Required font not found: %FONT%
echo No existing files were changed.
pause
exit /b 1

:XMLMISSING
echo [ERROR] Required fonts.xml is missing for %LANGNAME%.
echo No existing files were changed.
pause
exit /b 1

:BACKUPFAIL
echo [ERROR] Backup failed. Try running as administrator.
pause
exit /b 1

:CLEANFAIL
echo [ERROR] Failed to clean fonts from the previous language.
echo Check file permissions and try again.
pause
exit /b 1

:COPYFAIL
echo [ERROR] Failed to copy files. Check write permissions.
pause
exit /b 1

:VERIFYFAIL
echo [ERROR] Deployed files do not match the selected language.
pause
exit /b 1
