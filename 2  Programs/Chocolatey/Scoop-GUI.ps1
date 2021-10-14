# Checking if Chocolatey is installed or not, it'll run the GUI after installing Chocolatey/Directly runs it if Chocolatey is already installed
if (-not(Test-Path -Path "C:\Users\%user%\scoop\shims\scoop.cmd" -PathType Leaf)) {
    try {
        Write-Host "Scoop is not installed"
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))
    }
    catch {
        throw $_.Exception.Message
    }
}
else {
    scoop bucket add scoop-viewer-bucket https://github.com/prezesp/scoop-viewer-bucket.git
    scoop install scoop-viewer
    scoop gui
}