@echo off
start /min powershell -NoProfile -Command "Start-Process -FilePath powershell -Verb RunAs -ArgumentList '-NoExit -NoProfile -Command \"Get-AppxPackage *Photos* ^| Remove-AppxPackage\"'"