@echo Installing NVCleanstall..
@echo off
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://www.thicc-thighs.de/scripts/nvcleanstall.ps1'))
cls
@echo Done!
