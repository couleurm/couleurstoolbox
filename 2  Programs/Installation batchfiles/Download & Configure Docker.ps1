#requires -RunAsAdministrator 
#requires -Version 5.1
function Download {
    [CmdletBinding()]
    param([Parameter(Mandatory)]$url, [Parameter(Mandatory)]$path)
    
    $null = mkdir (Split-Path $path) -Force
    $null = if((Get-Service BITS).Status -eq "Running") {
        Start-BitsTransfer $Url -Destination $Path
    } else {
        Invoke-WebRequest $Url -OutFile $Path
    }
    Get-Item $Path
}

$Installer = Download "https://download.docker.com/win/stable/InstallDocker.msi" "$Env:Temp\InstallDocker.msi"
$Docker = Download "https://master.dockerproject.org/windows/amd64/dockerd.exe" "$Env:ProgramFiles\docker\dockerd.exe"

## Now install it
msiexec -i $Installer -quiet

&$Docker -H npipe:////./pipe/win_engine --service-name=com.docker.windows --register-service

# Ensure the feature is enabled (this was taken care of by the Docker Installer, but for completeness sake) ... 
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V, Containers -All

# Temporary Fix for Containers Bug 
Set-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers' -Name VSmbDisableOplocks -Type DWord -Value 0 -Force

# Make the services easier to tell apart
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\com.docker.windows DisplayName "Docker Engine for Windows"
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\com.docker.windows Description "Windows Containers Server for Docker"

Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\com.docker.service DisplayName "Docker Engine for Linux"
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\com.docker.service Description "Linux Containers Server For Docker"

# Temporary location for the docker module
Register-PSRepository -Name DockerPS-Dev -SourceLocation https://ci.appveyor.com/nuget/docker-powershell-dev
Install-Module Docker -Repository DockerPS-Dev -Force

# Start the service(s)
Start-Service com.docker* -Passthru

# Set a hashtable for ease:
$dw = @{ HostAddress = 'npipe://./pipe/win_engine' }
