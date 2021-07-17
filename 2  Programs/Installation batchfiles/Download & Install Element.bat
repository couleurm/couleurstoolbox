@echo Downloading Element, please wait 
@echo off 
powershell Invoke-WebRequest "https://packages.riot.im/desktop/install/win32/x64/Element%20Setup.exe"
echo Download done, execution is imminent
@echo off
%temp%\Element%20Setup.exe
pause
