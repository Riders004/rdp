@echo off

REM set "NGROK_URL=%~1"
REM if "%NGROK_URL%"=="" set "NGROK_URL=null"
REM set "USERNAME=%~2"
REM if "%USERNAME%"=="" set "USERNAME=runneradmin"
REM set "PASSWORD=%~3"
REM if "%PASSWORD%"=="" set "PASSWORD=OLDUSER-SER"

:: set "NGROK_URL=%~1"
:: if not defined NGROK_URL set "NGROK_URL=null"
:: set "USERNAME=%~2"
::if not defined USERNAME set "USERNAME=runneradmin"
::set "PASSWORD=%~3"
::if not defined PASSWORD set "PASSWORD=OLDUSER-SER"

REM set "NGROK_URL=%~1" & if "%NGROK_URL%"=="" set "NGROK_URL=null"
:: set "USERNAME=%~2" & if "%USERNAME%"=="" set "USERNAME=runneradmin"
REM set "PASSWORD=%~3" & if "%PASSWORD%"=="" set "PASSWORD=OLDUSER-SER"

set "NGROK_URL=%~1" & if "%NGROK_URL%"=="" set "NGROK_URL=null"
set "USERNAME=%~2" & if "%USERNAME%"=="" set "USERNAME=runneradmin"
set "PASSWORD=%~3" & if "%PASSWORD%"=="" set "PASSWORD=OLDUSER-SER"

del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By administrator" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat
net user "%USERNAME%" "%PASSWORD%" /add > nul
net localgroup administrators "%USERNAME%" /add >nul
net user administrator /active:yes >nul
net user installer /delete
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant "%USERNAME%" :F >nul
ICACLS C:\Windows\installer /grant "%USERNAME%" :F >nul
echo Successfully installed! If RDP is dead, rebuild again.
echo Setup complete!
echo Ngrok Tunnel URL/IP: "%NGROK_URL%"
echo Username: "%USERNAME%"
echo Password: "%PASSWORD%"
echo You can now log in via RDP or terminal."
ping -n 10 127.0.0.1 >nul
