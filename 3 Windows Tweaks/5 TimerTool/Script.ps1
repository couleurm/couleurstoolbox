Write-Host "Downloading TimerTool"
$url = "https://raw.githubusercontent.com/PrincessAkira/Hosting-Repo/main/Install-STRService.ps1"
Write-Host "Done..."
Invoke-WebRequest -Uri $url -OutFile "service.ps1"
    Powershell.exe -File "service.ps1"
    Write-Host "Installed TimerTool Service. Please restart..."
    Remove-Item -Path "service.ps1"
    Remove-Item -Path "STR_Install.log"