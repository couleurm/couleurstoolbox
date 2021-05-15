@echo Downloading Steam, please wait
@echo off
powershell Invoke-WebRequest "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" -OutFile "%temp%\Steam_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\Steam_install.exe
pause