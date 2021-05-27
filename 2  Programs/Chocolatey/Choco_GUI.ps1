Write-Host
Write-Host Installing Chocolatey. Ignore the following yellow lines if you have it already installed.
Write-Host
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#Installs Chocolatey

#-------------------------------------------------------------#
#----Initial GUI Declarations---------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="720" Height="300" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="0,0,0,0" Title="Chocolatey program installer">
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



$DataObject = ConvertFrom-Json @"

{
    "apps" : [
        {"name" : "Discord","IsChecked" : false,"icon":"https://cdn.discordapp.com/attachments/830861516818350090/845690194882461726/discord.png"},
        {"name" : "Chrome","IsChecked" : false,"icon":"https://cdn.discordapp.com/attachments/830861516818350090/845690191888908298/chrome.png"},
        {"name" : "7Zip","IsChecked" : false,"icon":"https://media.discordapp.net/attachments/830861516818350090/845691656485208084/7ziplogo.png"},
        {"name" : "Everything","IsChecked" : false,"icon":"https://media.discordapp.net/attachments/830861516818350090/845692307129761812/everything.png"},
        {"name" : "FFmpeg","IsChecked" : false,"icon":"https://media.discordapp.net/attachments/830861516818350090/845692912117219348/ffmpeg_logo.png"},
        {"name" : "paintnet","IsChecked" : false,"icon":"https://media.discordapp.net/attachments/830861516818350090/845693909996011520/paint.png"},
        {"name" : "PowerToys","IsChecked" : false,"icon":"https://tweakers.net/ext/i/2003837622.png"},
        {"name" : "Steam","IsChecked" : false,"icon":"https://s3.amazonaws.com/freebiesupply/large/2x/steam-logo-transparent.png"},
        {"name" : "VLC","IsChecked" : false,"icon":"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/VLC_Icon.svg/904px-VLC_Icon.svg.png"},
        {"name" : "MPV","IsChecked" : false,"icon":"https://mpv.io/images/mpv-logo-128-0baae5aa.png"},
        {"name" : "Telegram","IsChecked" : false,"icon":"https://duckduckgo.com/i/1aacfedb.png"},
        {"name" : "Minecraft","IsChecked" : false,"icon":"https://media.discordapp.net/attachments/830861516818350090/845697570608119829/minecraft.png"},
        {"name" : "EarTrumpet","IsChecked" : false,"icon":"https://softati.com/wp-content/uploads/2019/03/EarTrumpet-Icon-50x50.png"},
        {"name" : "VSCode","IsChecked" : false,"icon":"https://iseif.dev/wp-content/uploads/2019/06/vscode-logo.png"},
        {"name" : "ShareX","IsChecked" : false,"icon":"https://duckduckgo.com/i/cb4de35d.png"},
        {"name" : "TranslucentTB","IsChecked" : false,"icon":"https://raw.githubusercontent.com/TranslucentTB/TranslucentTB/release/TranslucentTB/TTB_color.ico"},
	{"name" : "Spotify","IsChecked" : false,"icon":"https://img.talkandroid.com/uploads/2016/01/spotify-app-logo.png"}
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


