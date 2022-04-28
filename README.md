<p align="center">
    Couleur's Toolbox  </br>
    <strong>An easier way to tweak Windows, its settings, & quickly install & configure programs.</strong>
</p>

<p align="center">
  <a href="https://github.com/couleurm/couleurstoolbox/archive/refs/heads/main.zip">Download</a>
  •
  <a href="https://dsc.gg/ctt">Discord Server</a>
  •
  <a href="https://github.com/couleurm/couleurstoolbox/blob/main/LICENSE.md">License</a>
</p>

This has been made with the intent of making it easier to tweak Windows and it's settings, quickly install & configure programs. It consists of a bunch of scripts and links to make your life easier, weither you're a newbie or a veteran.

If you wish to implement this in a custom ISO, please [contact me](https://dsc.gg/CTT) beforehand.

## Download
If you want to chuck the toolbox on a USB to reinstall windows with it, then download the source code [here](https://couleur.tech/toolbox/download).

Here's a little script to download, unzip it on your desktop using PowerShell:

    powershell iwr -useb https://github.com/couleur-tweak-tips/utils/raw/main/InstallToolbox.ps1 | iex

To run it, simply copy this string and do Windows+R, paste it in and press enter.

### What the script does:
- Deletes the old toolbox if there ever was one.
- Installs Chocolatey
- Installs FFmpeg
- Unzips the toolbox to your desktop
- Opens it in the file explorer

# Overview of the toolbox's content

This will never be accurate, but will still give you a solid idea of most of what's in there.

## 1. [(Re)install windows](https://github.com/couleurm/couleurstoolbox/tree/main/1%20(Re)install%20Windows)

  - Link to Microsoft's official download page
  - Link to a little handy tutorial I made to get an .ISO instead of an upgrade tool (s/o fr33thy)
  - Link to Rufus.ie and NTLite.com
  - Windows link to activate Windows

## 2. [Programs](https://github.com/couleurm/couleurstoolbox/tree/main/2%20%20Programs)

A bunch of bats that will let you atomatically download & install some programs such as: 
Brave, Chrome, Discord, Lightshot, N++, OBS 25.0.8, SearchEverything, Steam, Telegram, VLC & Anydesk (that list will get longer as time goes)
- Chocolatey
    - Batch file that installs you chocolatey
    - Editeable batch file that installs most known programs, it is strongly recommended that you edit it before running it.
    - Full chocolatey package list

- Program links
    - A bunch of links to program's websites.
        - Internet browsers
        - Common programs
        - Less common programs
        - PC monitoring & overclocking
        - VPNs
        - Aesthetic focused
        - Gaming peripherals programs (iCUE, Razer Synapse, G-Hub, etc..)

## 3. [Windows tweaks](https://github.com/couleurm/couleurstoolbox/tree/main/3%20Windows%20Tweaks)

- **Quality of life fixes**
    - Scripts to uninstall Movies & TV and install VLC
    - Scripts to re-enable the legacy photo viewer & to uninstall W10's current photo viewer
    - Windows+R folder link
    - SetUserFTA: automatically set the default file types for every file extension.
    - `.lnks` to customize the Windows Start menu
    - `.Regs` to add/remove TakeOwnership in the file context menu

- **Debloating scripts**
    - Chris Titus Tech's toolbox
    - Sycnex's Windows10Debloater
  
- Remove mouse acceleration
MarkC's .regs to fix aceleration
<details>
  <summary>Links to a bunch of specific Windows 10 settings</summary>
    
    - Default Apps
    - Disk manager
    - Game mode
    - GPU scheduling
    - List of programs
    - Mouse acceleration
    - Network status
    - Power plan
    - Restore point
    - Sound control panel
    - Time and Date
    - User Account Control settings
    - Windows appearance
    - And a lot more!

</details>

## 4. [Nvidia Drivers](https://github.com/couleurm/couleurstoolbox/tree/main/4%20Nvidia%20Drivers)

- Links to NVCleanstall and DDU's websites to get latest.
- VCleanstall 1.9.0 & DDU v18.3.9
- Link to ChrisTitusTech's tutorial on these two programs
## 5.  [OBS](https://github.com/couleurm/couleurstoolbox/tree/main/5%20OBS)

Profiles (SOON)
Super dark & Flat Dark themes (with `.lnk` to where to where you need to drag them in)
Automatic download & install of OBS 25.0.8
Link to OBSproject's latest GitHub releases
## 6.  [LunarClient (Minecraft)](https://github.com/couleurm/couleurstoolbox/tree/main/6%20LunarClient) 

- `.lnk` to download LC
- #optimize-lunar-client channel link on [CTT](https://dsc.gg/CTT)
- `.lnk` to resourcepacks, .lunarclient
- My ov3rlay bundle & bunch of resource pack folder links.
. 
## 7. [FFmpeg](https://github.com/couleurm/couleurstoolbox/tree/main/7%20%20FFmpeg)

- Fake upscale bats for Nvenc/AMF/x264 encoders
        - Fake upscale to 4K with SendTo method, using XBR & Lanczos scale filters
        - T-mixing
- Compression scripts by [vladaad](https://github.com/vladaad)
    - Compressor bat that compresses the video down to a specific size (8mb for Discord)
    - libx264 compressors
    - Downscale proxy
- A few `.url` download links to FF-utils, Flowframes, Losslesscut and Voukoder.

# Credits

- vladaad for the amazing ffmpeg scripts and giving advice on tech
- Every single contributor in CTT

Inspiration came from:

- [Fr33thy's to-do folder](https://drive.google.com/drive/folders/1ocl1dZpyeRjgNGpmEIA-Ay4BJ8Jex_l1)
- [ChrisTitusTech's toolbox](https://github.com/ChrisTitusTech/win10script)

Join [**CTT**](https://dsc.gg/ctt) (DM me on there if you wish to contact me)
