@echo off
where.exe powershell.exe >NUL
if %ERRORLEVEL% EQU 1 echo PowerShell could not be found, (broke windows?) && pause>nul && exit
powershell.exe -ExecutionPolicy Bypass -NoExit -NoLogo -NoExit -Command ^
"[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12';iex(irm tl.ctt.cx);Optimize-OBS"