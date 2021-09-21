@echo Downloading IObit-Unlocker, please wait
@echo off
powershell Invoke-WebRequest "https://cdn.iobit.com/dl/unlocker-setup.exe" -OutFile "%homepath%\Downloads\Anydesk.exe"
@echo off
pause