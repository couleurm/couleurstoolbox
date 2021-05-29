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
set hwaccel=cpu
set codec=H264
::
:: ADVANCED OPTIONS
:: Be careful, only change them if you know what they do!
::
set audioencoder=libopus
set audioencoderopts=-b:a 320k
set container=mkv
set forcepreset=no
set forcequality=no
set presetcommand=-preset 
set forcedencoderopts=no
set customvideofilters=,mpdecimate=max=6
:: DON'T TOUCH ANYTHING BEYOND THIS POINT
:: Input check
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: Encoder options
if %forcedencoderopts% == no (
    :: Encoder-specific options
    if %hwaccel% == cpu (
        if %codec% == H264 (
            set encoderopts=-c:v libx264
            set qualityarg=-crf
            set quality=15
        )
        if %codec% == HEVC (
            set encoderopts=-c:v libx265
            set qualityarg=-crf
            set quality=19
        )
    if %hwaccel% == NVIDIA (
        set hwaccelarg=-hwaccel cuda
        if %codec% == H264 (
            set encoderopts=-c:v h264_nvenc -rc constqp
            set qualityarg=-qp
            set quality=17
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_nvenc -rc constqp
            set qualityarg=-qp
            set quality=21
        )
    )
    if %hwaccel% == AMD (
        set hwaccelarg=-hwaccel d3d11va
        if %codec% == H264 (
            set encoderopts=-c:v h264_amf
            set quality=16
            set amd=yes
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_amf
            set quality=20
            set amd=yes
        )
    )
    if %hwaccel% == Intel (
        set hwaccelarg=-hwaccel d3d11va
        if %codec% == H264 (
            set encoderopts=-c:v h264_qsv
            set qualityarg=-global_quality
            set quality=18
        )
        if %codec% == HEVC (
            set encoderopts=-c:v hevc_qsv
            set qualityarg=-global_quality
            set quality=22
        )
    )
    :: Global options
    set globaloptions=-g 900
    if %amd% == yes (
        set encoderopts=%encoderopts% -qp_i %quality% -qp_p %quality% -qp_b %quality%
    ) else (
        set encoderopts=%encoderopts% %qualityarg% %quality%
    )
)