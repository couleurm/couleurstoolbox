@echo Downloading Notepad++, please wait
@echo off
powershell Invoke-WebRequest "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.5/npp.7.9.5.Installer.exe" -OutFile "%temp%\NPP_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\NPP_install.exe
pause