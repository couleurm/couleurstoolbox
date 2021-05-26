@echo Downloading Google Chrome, please wait
@echo off
powershell Invoke-WebRequest "https://laptop-updates.brave.com/latest/winx64" -OutFile "C:\Windows\Temp\Brave.exe"
echo Download done, execution is imminent
C:\Windows\Temp\Brave.exe