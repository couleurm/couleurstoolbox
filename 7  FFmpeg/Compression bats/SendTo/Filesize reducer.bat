@echo off
:: ----------------------------
:: YOU NEED FFMPEG 4.4 OR NEWER
:: ----------------------------
:: Set hardware acceleration:
:: CPU/NVIDIA/AMD
:: Set codec to H264 if it doesn't work
:: Set nvidiacompat to yes if you encounter issues (mostly laptops)
:: If you use CPU and don't want to use hardware acceleration, set enablecpuwarning to no
::
set hwaccel=CPU
set codec=HEVC
set nvidiacompat=no
set enablecpuwarning=yes
set cpupreset=veryfast
::
:: Don't touch anything beyond this point
::
:: Input file check
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: Warning
if %hwaccel% == CPU (
    if %enablecpuwarning% == yes (
        echo Warning: this script is using your CPU by default. Please open it and change hardware acceleration, or set enablecpuwarning to no.
        pause
    )
)
:: Setting settings
if %hwaccel% == CPU (
    if %codec% == HEVC (
        set options=-c:v libx265 -preset %cpupreset% -crf 18
    )
    if %codec% == H264 (
        set options=-c:v libx264 -preset %cpupreset% -crf 16
    )
)
if %hwaccel% == NVIDIA (
    if %nvidiacompat% == yes (
        set inputopt=-hwaccel cuda -threads 8
    ) else (
        set inputopt=-hwaccel cuda -hwaccel_output_format cuda -threads 8
    )
    if %codec% == HEVC (
        set options=-c:v hevc_nvenc -preset p7 -rc constqp -qp 21
    )
    if %codec% == H264 (
        set options=-c:v h264_nvenc -preset p7 -rc constqp -qp 18
    )
)
if %hwaccel% == AMD (
    set inputopt=-hwaccel d3d11va
    if %codec% == HEVC (
        set options=-c:v hevc_amf -quality quality -rc cqp -qp_i 19 -qp_p 20 -qp_b 22
    )
    if %codec% == H264 (
        set options=-c:v h264_amf -quality quality -rc cqp -qp_i 16 -qp_p 17 -qp_b 19
    )
)
:: Actual FFmpeg command
ffmpeg %inputopt% -i %1 %options% -g 600 -map 0 -strict -2 -c:a copy "%~dpn1 (smaller).mp4"
pause