@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
mkdir %appdata%\mpv
echo What config file do you want?
echo Heavy - uses high quality scaling and forces max quality with youtube (recommended for most PCs)
echo Medium - uses normal quality scaling and uses only VP9 or H264 with youtube (recommended for low-end PCs)
echo Light - uses low quality scaling and forces H264 with youtube (recommended for power efficiency with laptops or very low-end PCs)
echo Default is Light
set /p answer=Type here:  
if %answer% == Heavy (
    copy mpv.heavy.conf %appdata%\mpv\mpv.conf
) else if %answer% == Medium (
    copy mpv.medium.conf %appdata%\mpv\mpv.conf
) else (
    copy mpv.light.conf %appdata%\mpv\mpv.conf
)
mkdir C:\mpv
copy z.ps1 C:\mpv\install.ps1
cd C:\mpv
powershell -noprofile -nologo -executionpolicy bypass -File C:\mpv\install.ps1
del /q *.7z
del /s /q 7z\*.*
rmdir /s /q 7z
installer\mpv-install.bat
@pause