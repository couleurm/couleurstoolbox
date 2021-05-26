@echo Downloading Telegram, please wait
@echo off
powershell Invoke-WebRequest "https://telegram.org/dl/desktop/win64" -OutFile "%temp%\Telegram_install.exe"
echo Download done, execution is imminent
@echo off
%temp%\Telegram_install.exe
pause