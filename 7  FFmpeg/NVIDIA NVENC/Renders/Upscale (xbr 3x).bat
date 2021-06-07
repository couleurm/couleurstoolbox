@echo off
:: Hardware acceleration
:: Available options (same as in ffmpeg -hwaccel):
:: cpu (none)
:: NVIDIA (NVDEC/ENC)
:: AMD (d3d11va+AMF)
:: Intel (d3d11va+QSV)
:: any other hwaccel
:: Available codecs:
:: HEVC
:: H264
::
set upscalingalgo=xbr
set targetresolution=2160
set hwaccel=NVIDIA
set codec=HEVC
set cpupreset=veryfast
set enablecpuwarning=yes
::
:: Advanced options
::
set xbrscalefactor=3
set container=mp4
set forcepreset=no
set forcequality=no
set presetcommand=-preset 
set forcedencoderopts=no
:: DON'T TOUCH ANYTHING BEYOND THIS POINT
color 0f
:: Input check
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: CPU check
if %hwaccel% == cpu (
    if %enablecpuwarning% == yes (
        echo Warning: this script is using your CPU by default. Please open it and change hardware acceleration, or set enablecpuwarning to no.
        pause
    )
)
:: Encoder options (universal for all scripts)
if %forcedencoderopts% == no (
    :: Choosing encoder
    if %hwaccel% == cpu (
        if %codec% == H264 (
            set encoderopts=-c:v libx264
            set encpreset=%cpupreset%
            set qualityarg=-crf
            set quality=10
        )
        if %codec% == HEVC (
            set encoderopts=-c:v libx265
            set encpreset=%cpupreset%
            set qualityarg=-crf
            set quality=14
        )
    )
    if %hwaccel% == NVIDIA (
        set hwaccelarg=-hwaccel cuda -threads 8
        if %codec% == H264 (
            set encoderopts=-c:v h264_nvenc -rc constqp
            set encpreset=p7
            set qualityarg=-qp
            set quality=15
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_nvenc -rc constqp
            set encpreset=p7
            set qualityarg=-qp
            set quality=18
        )
    )
    if %hwaccel% == AMD (
        set hwaccelarg=-hwaccel d3d11va
        if %codec% == H264 (
            set encoderopts=-c:v h264_amf
            set encpreset=quality
            set quality=12
            set amd=yes
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_amf
            set encpreset=quality
            set quality=16
            set amd=yes
        )
    )
    if %hwaccel% == Intel (
        set hwaccelarg=-hwaccel d3d11va
        if %codec% == H264 (
            set encoderopts=-c:v h264_qsv
            set encpreset=veryslow
            set qualityarg=-global_quality:v
            set quality=15
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_qsv
            set encpreset=veryslow
            set qualityarg=-global_quality:v
            set quality=18
        )
    )
    :: Fuck you batch
    set recreatecommand=yes
) else (
    :: Ability to force encoder options
    set encoderarg=%forcedencoderopts%
    set recreatecommand=no
)
if NOT %forcepreset% == no (
    set encpreset=%forcepreset%
)
if %recreatecommand% == yes (
    if %amd%1 == yes1 (
        set encoderarg=%encoderopts% -qp_i %quality% -qp_p %quality% -qp_b %quality% %globaloptions% -quality %encpreset%
    ) else (
        set encoderarg=%encoderopts% %qualityarg% %quality% %globaloptions% %presetcommand% %encpreset%
    )
)
:: Filter
if %upscalingalgo%0 == xbr0 (
   set filter=-vf xbr=%xbrscalefactor%
) else (
   set filter=-vf scale=-2:%targetresolution%:flags=%upscalingalgo%
)
:: Running
echo\
echo Encoding...
echo Upscaling to 2160p using the "%upscalingalgo%" algorithm
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -stats %hwaccelarg% -i %1 ^
%filter% %encoderarg% ^
-c:a copy -vsync vfr "%~dpn1 (upscaled).%container%"
:: End
echo\
echo Done!
echo\
color 0A
pause