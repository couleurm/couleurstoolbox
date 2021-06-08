# Checking if Chocolatey is installed or not, it'll run the GUI after installing Chocolatey/Directly runs it if Chocolatey is already installed
if (-not(Test-Path -Path "C:\ProgramData\chocolatey\choco.exe" -PathType Leaf)) {
    try {
        Write-Host "Chocolatey is not installed"
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    catch {
        throw $_.Exception.Message
    }
}
else {
#-------------------------------------------------------------#
#----Initial GUI Declarations---------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="720" Height="300" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="0,0,0,0" Title="Couleur's GUI for Chocolatey, a program package manager">
<Grid>
    
    <Border Width="690" Height="240" Margin="10,10,0,0" HorizontalAlignment="Left" VerticalAlignment="Top">
    <ItemsControl Margin="50,50,0,0" ItemsSource="{Binding apps}" Name="kp4iw19ysztny">


<ItemsControl.ItemsPanel>
				<ItemsPanelTemplate>
					<WrapPanel/>
				</ItemsPanelTemplate>
			</ItemsControl.ItemsPanel>

    	<ItemsControl.ItemTemplate>
				<DataTemplate>
				    
				    
				    <StackPanel Orientation="Horizontal">
				    <Image HorizontalAlignment="Left" Stretch="Fill" Width="15" Height="15" VerticalAlignment="Top" Margin="0,0,0,0" Source="{Binding icon}" Name="kp4iw19yzni1f"/>
					<CheckBox Content="{Binding name}" IsChecked="{Binding IsChecked}" Margin="0,0,15,17" Name="kp4iw19zp2lzs"/>
				
					</StackPanel>
					
					
					
				</DataTemplate>
			</ItemsControl.ItemTemplate>     
    </ItemsControl> 
    </Border>

 <Button Content="Install selected" HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="315,200,0,0" Name="kp4iw19zkylmz"/>

<TextBlock HorizontalAlignment="Left" VerticalAlignment="Top" TextWrapping="Wrap" Text="{Binding resultString}" Margin="17,372,0,0" Name="kp4iw19zpwbt4"/>
</Grid>
 
 </Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#


function install{
    
Async {
    
    $SelectedApps = $State.apps | Where-Object {$_.IsChecked}
    
    choco feature enable -n allowGlobalConfirmation
   
     foreach($app in $SelectedApps){
         
         $State.resultString = "Installing " + $app.name
         choco install $app.name -y
       
        }
        
        $State.resultString = "All Apps have been installed"
        
}
        
}


#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }


$kp4iw19zkylmz.Add_Click({install $this $_})

$State = [PSCustomObject]@{}


Function Set-Binding {
    Param($Target,$Property,$Index,$Name)
 
    $Binding = New-Object System.Windows.Data.Binding
    $Binding.Path = "["+$Index+"]"
    $Binding.Mode = [System.Windows.Data.BindingMode]::TwoWay
    


    [void]$Target.SetBinding($Property,$Binding)
}

function FillDataContext($props){

    For ($i=0; $i -lt $props.Length; $i++) {
   
   $prop = $props[$i]
   $DataContext.Add($DataObject."$prop")
   
    $getter = [scriptblock]::Create("return `$DataContext['$i']")
    $setter = [scriptblock]::Create("param(`$val) return `$DataContext['$i']=`$val")
    $State | Add-Member -Name $prop -MemberType ScriptProperty -Value  $getter -SecondValue $setter
               
       }
   }

#       {"name" : "PLACEHOLDERNAME",		"IsChecked" : false,"icon":"PLACEHOLDERURL"},

$DataObject = ConvertFrom-Json @"

{
    "apps" : [
        {"name" : "Chrome",		"IsChecked" : false,"icon":"https://i.imgur.com/6aMbDrF.png"},
        {"name" : "7Zip",		"IsChecked" : false,"icon":"https://i.imgur.com/zVZCzqB.png"},
        {"name" : "Everything",		"IsChecked" : false,"icon":"https://i.imgur.com/oNtjX6L.png"},
        {"name" : "FFmpeg",		"IsChecked" : false,"icon":"https://i.imgur.com/s56G8XH.png"},
        {"name" : "FFmpeg-batch",	"IsChecked" : false,"icon":"https://i.imgur.com/I4ePtig.png"},
        {"name" : "paint.net",	 	"IsChecked" : false,"icon":"https://i.imgur.com/x5OBRYW.png"},
        {"name" : "PowerToys", 	 	"IsChecked" : false,"icon":"https://i.imgur.com/04ZEIcW.png"},
        {"name" : "Steam",		"IsChecked" : false,"icon":"https://i.imgur.com/vD3M6ep.png"},
        {"name" : "VLC",		"IsChecked" : false,"icon":"https://i.imgur.com/W6mEmmi.png"},
        {"name" : "MPV",		"IsChecked" : false,"icon":"https://i.imgur.com/bDqMczn.png"},
        {"name" : "Discord",		"IsChecked" : false,"icon":"https://i.imgur.com/1tRhtAk.png"},
        {"name" : "Telegram",		"IsChecked" : false,"icon":"https://i.imgur.com/377PN6V.png"},
        {"name" : "Minecraft",		"IsChecked" : false,"icon":"https://i.imgur.com/a1VgL8H.png"},
        {"name" : "EarTrumpet",		"IsChecked" : false,"icon":"https://i.imgur.com/qqsquNG.png"},
        {"name" : "VSCode",		"IsChecked" : false,"icon":"https://i.imgur.com/gAN9pW1.png"},
        {"name" : "ShareX",		"IsChecked" : false,"icon":"https://i.imgur.com/cGpMoLw.png"},
        {"name" : "TranslucentTB",	"IsChecked" : false,"icon":"https://i.imgur.com/DQknmr1.png"},
		{"name" : "Spotify",		"IsChecked" : false,"icon":"https://i.imgur.com/t0xGHhr.png"},
        {"name" : "WindirStat",		"IsChecked" : false,"icon":"https://i.imgur.com/yguJS4d.png"},
        {"name" : "notepadplusplus",	"IsChecked" : false,"icon":"https://i.imgur.com/DB98n9l.png"},
        {"name" : "AutoHotKey",		"IsChecked" : false,"icon":"https://i.imgur.com/ntAZE99.png"},
        {"name" : "Legendary",		"IsChecked" : false,"icon":"https://i.imgur.com/uDln3rF.png"},
        {"name" : "OBS-studio",		"IsChecked" : false,"icon":"https://i.imgur.com/cSMv29M.png"}
        ],
        "resultString" : ""
}

"@

$DataContext = New-Object System.Collections.ObjectModel.ObservableCollection[Object]
FillDataContext @("apps","resultString") 

$Window.DataContext = $DataContext
Set-Binding -Target $kp4iw19ysztny -Property $([System.Windows.Controls.ItemsControl]::ItemsSourceProperty) -Index 0 -Name "apps"



Set-Binding -Target $kp4iw19zpwbt4 -Property $([System.Windows.Controls.TextBlock]::TextProperty) -Index 1 -Name "resultString"




$Global:SyncHash = [HashTable]::Synchronized(@{})
$SyncHash.Window = $Window
$Jobs = [System.Collections.ArrayList]::Synchronized([System.Collections.ArrayList]::new())
$initialSessionState = [initialsessionstate]::CreateDefault()

Function Start-RunspaceTask
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$True,Position=0)][ScriptBlock]$ScriptBlock,
          [Parameter(Mandatory=$True,Position=1)][PSObject[]]$ProxyVars)
            
    $Runspace = [RunspaceFactory]::CreateRunspace($InitialSessionState)
    $Runspace.ApartmentState = 'STA'
    $Runspace.ThreadOptions  = 'ReuseThread'
    $Runspace.Open()
    ForEach($Var in $ProxyVars){$Runspace.SessionStateProxy.SetVariable($Var.Name, $Var.Variable)}
    $Thread = [PowerShell]::Create('NewRunspace')
    $Thread.AddScript($ScriptBlock) | Out-Null
    $Thread.Runspace = $Runspace
    [Void]$Jobs.Add([PSObject]@{ PowerShell = $Thread ; Runspace = $Thread.BeginInvoke() })
}

$JobCleanupScript = {
    Do
    {    
        ForEach($Job in $Jobs)
        {            
            If($Job.Runspace.IsCompleted)
            {
                [Void]$Job.Powershell.EndInvoke($Job.Runspace)
                $Job.PowerShell.Runspace.Close()
                $Job.PowerShell.Runspace.Dispose()
                $Job.Powershell.Dispose()
                
                $Jobs.Remove($Job)
            }
        }

        Start-Sleep -Seconds 1
    }
    While ($SyncHash.CleanupJobs)
}

Get-ChildItem Function: | Where-Object {$_.name -notlike "*:*"} |  select name -ExpandProperty name |
ForEach-Object {       
    $Definition = Get-Content "function:$_" -ErrorAction Stop
    $SessionStateFunction = New-Object System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList "$_", $Definition
    $InitialSessionState.Commands.Add($SessionStateFunction)
}


$Window.Add_Closed({
    Write-Verbose 'Halt runspace cleanup job processing'
    $SyncHash.CleanupJobs = $False
})

$SyncHash.CleanupJobs = $True
function Async($scriptBlock){ Start-RunspaceTask $scriptBlock @([PSObject]@{ Name='DataContext' ; Variable=$DataContext},[PSObject]@{Name="State"; Variable=$State},[PSObject]@{Name = "SyncHash";Variable = $SyncHash})}

Start-RunspaceTask $JobCleanupScript @([PSObject]@{ Name='Jobs' ; Variable=$Jobs })



$Window.ShowDialog()
}