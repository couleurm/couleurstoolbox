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
set cpupreset=fast
set enablecpuwarning=no
::
:: Advanced options
::
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
:: TMIX-SPECIFIC QUESTIONS
set /p infps=FPS of your input file: 
set /p outfps=FPS you want to render in: 
set /p upscale=Do you want to upscale to 4k? y, xbr or n: 
if %upscale%0 == xbr0 (
   set /p upscalefactor=How much do you want to upscale: 
)
set /p dedup=Do you want to deduplicate frames? Can eliminate encoding/rendering lag, y or n: 
:: math
set /A tmixframes=%infps%/%outfps%
:: Upscaling
if %upscale%0 == y0 (
   set upscalingfilter=,scale=3840:2160:flags=neighbor
)
if %upscale%0 == xbr0 (
   set upscalingfilter=,xbr=%upscalefactor%
)
:: Dedup
if %dedup%0 == y0 (
   set dedupfilter=mpdecimate=max=2,
)
:: Running
echo\
echo Encoding...
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -stats %hwaccelarg% -i %1 ^
-vf %dedupfilter%tmix=frames=%tmixframes%:weights="1",fps=%outfps%%upscalingfilter% ^
%encoderarg% -c:a copy -vsync vfr "%~dpn1 (resampled).%container%"
:: End
echo\
echo Done!
echo\
color 0A
pause