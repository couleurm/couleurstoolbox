cd %systemroot%\system32
call :IsAdmin

Reg.exe delete "HKCR\Microsoft.PowerShellScript.1\Shell\runas" /f
Reg.exe add "HKCR\Microsoft.PowerShellScript.1\Shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f
Reg.exe add "HKCR\Microsoft.PowerShellScript.1\Shell\runas\command" /ve /t REG_SZ /d "powershell \"-Command\" \"if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & '%%1'\"" /f
Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof