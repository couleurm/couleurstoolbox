@echo Downloading OBS 25.0.8 (70.1 MB), please wait
@echo off
powershell Invoke-WebRequest "https://github.com/obsproject/obs-studio/releases/download/25.0.8/OBS-Studio-25.0.8-Full-Installer-x64.exe" -OutFile "%temp%\OBS_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\OBS_install.exe
pause