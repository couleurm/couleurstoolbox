@echo Downloading SearchEverything, please wait
@echo off
powershell Invoke-WebRequest "https://www.voidtools.com/Everything-1.4.1.1005.x64-Setup.exe" -OutFile "%temp%\SearchEverything_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\SearchEverything_install.exe
pause