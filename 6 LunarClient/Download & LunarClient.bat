@echo Downloading Lunar Client, please wait
@echo off
powershell Invoke-WebRequest "https://launcherupdates.lunarclientcdn.com/Lunar%20Client%20v2.7.2.exe" -OutFile "%homepath%\Downloads\LunarSetup.exe"
echo Download done, execution is imminent
%homepath%\Downloads\LunarSetup.exe