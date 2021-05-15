@echo Downloading Lightshot, please wait
@echo off
powershell Invoke-WebRequest "https://app.prntscr.com/build/setup-lightshot.exe" -OutFile "%temp%\Lightshot_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\Lightshot_install.exe
pause