@echo Downloading AnyDesk, please wait
@echo off
powershell Invoke-WebRequest "https://download.anydesk.com/AnyDesk.exe" -OutFile "%homepath%\Downloads\Anydesk.exe"
@echo off
pause