@echo Downloading Lunar Client, please wait
@echo off
powershell Invoke-WebRequest "https://launcherupdates.lunarclientcdn.com/Lunar%20Client%20v2.7.3.exe" -OutFile "%temp%\LC_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\LC_install.exe
pause