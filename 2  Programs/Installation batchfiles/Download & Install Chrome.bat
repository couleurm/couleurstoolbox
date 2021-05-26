@echo Downloading Google Chrome, please wait
@echo off
powershell Invoke-WebRequest "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi" -OutFile "%temp%\Chrome.msi"
echo Download done, execution is imminent
%temp%\Chrome.msi