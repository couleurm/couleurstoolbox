@echo Downloading VLC, please wait
@echo off
powershell Invoke-WebRequest "https://get.videolan.org/vlc/3.0.14/win64/vlc-3.0.14-win64.exe" -OutFile "%temp%\VLC_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\VLC_install.exe
pause