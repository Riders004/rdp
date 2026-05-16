@echo off
set "NGROK_URL=%~1"
set "USERNAME=%~2"
set "PASSWORD=%~3"

if "%NGROK_URL%"=="" set "NGROK_URL=null"
if "%USERNAME%"=="" set "USERNAME=administrator"
if "%PASSWORD%"=="" set "PASSWORD=OLDUSER#06"

echo Setting up RDP for user: %USERNAME%

:: Try to set password for an existing user first
net user "%USERNAME%" "%PASSWORD%" > nul
if errorlevel 1 (
    echo User "%USERNAME%" not found. Creating new user...
    net user "%USERNAME%" "%PASSWORD%" /add > nul
)

:: Ensure user is active and has administrator rights
net user "%USERNAME%" /active:yes > nul
net localgroup administrators "%USERNAME%" /add > nul

:: Also ensure the default Administrator account is active and has a known password as a fallback
if /I NOT "%USERNAME%"=="administrator" (
    echo Setting fallback password for built-in Administrator...
    net user administrator "%PASSWORD%" > nul
    net user administrator /active:yes > nul
)

:: Enable RDP and related services
net config server /srvcomment:"Windows Server RDP" > nul
diskperf -Y > nul
sc config Audiosrv start= auto > nul
sc start audiosrv > nul

echo.
echo ==============================================
echo Successfully installed!
echo Ngrok Tunnel URL: %NGROK_URL%
echo Username: %USERNAME%
echo Password: %PASSWORD%
echo ==============================================
echo.
echo You can now connect via RDP.
