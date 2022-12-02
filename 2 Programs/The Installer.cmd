:: Learn more about The Installer - https://github.com/couleur-tweak-tips/the-installer
@echo off
title The Installer
where.exe PowerShell.exe >NUL
if %ERRORLEVEL% EQU 1 echo PowerShell could not be found, (broke windows?) && pause>nul && exit
PowerShell.exe -ExecutionPolicy Bypass -NoLogo -NoExit -Command ^
"[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12';iex(irm https://git.io/J9GI7)"