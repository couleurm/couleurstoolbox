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
:: Questions
set /p audiofile=What audio file should be added? "no" to keep original audio: 
if NOT %audiofile% == no (
    set /p audiostarttime=Where should the audio file start? (in seconds): 
)
set /p starttime=Where do you want your clip to start (in seconds): 
set /p time=How long should the clip be (in seconds): 
set /p upscaleto4k=Do you want to upscale to 4K? (yes or no): 
set /p fadetime=How long do you want the clip to fade in and out? (in seconds, 0=off): 
:: Encoder options
if %forcedencoderopts% == no (
    :: Choosing encoder
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
    :: Fuck you batch
    set recreatecommand=yes
) else (
    :: Ability to force encoder options
    set encoderarg=%forcedencoderopts%
    set recreatecommand=no
)
set globaloptions=-g 900
if %recreatecommand% == yes (
    if %amd%1 == yes1 (
        set encoderarg=!encoderopts! -qp_i %quality% -qp_p %quality% -qp_b %quality% %globaloptions%
    ) else (
        set encoderarg=%encoderopts% %qualityarg% %quality% %globaloptions%
    )
)
:: FFmpeg command creation
:: Input filters
set filterinput=[0:v]format=yuv420p[fadeinput]
:: Audio mix
if %audiofile% == no (
    set filteramix=
    set amixoutputname=0:a:0
) else (
    set filteramix=;[0:a:0][1:a:0]amix=inputs=2[mixedaudio]
    set amixoutputname=mixedaudio
)
:: Fading
set /A endfadestarttime=%time%-%fadetime%
if %fadetime% == 0 (
    set filterfade=
    set fadeaoutputname=%amixoutputname%
    set fadevoutputname=fadeinput
) else (
    set filterfade=;[%amixoutputname%]afade=t=in:st=0:d=%fadetime%,afade=t=out:st=%endfadestarttime%:d=%fadetime%[finalaudio];[fadeinput]fade=t=in:st=0:d=%fadetime%,fade=t=out:st=%endfadestarttime%:d=%fadetime%[scaleinput]
    set fadeaoutputname=finalaudio
    set fadevoutputname=scaleinput
)
:: Upscaling to 4K
if %upscaleto4k% == yes (
    set filterupscale=;[%fadevoutputname%]scale=-2:2160:flags=lanczos[finalvideo]
    set upscaleoutputname=finalvideo
) else (
    set filterupscale=
    set upscaleoutputname=%fadevoutputname%
)
:: Audio input
if %audiofile% == no (
    set ainput=
) else (
    set ainput=-ss %audiostarttime% -t %time% -i %audiofile%
)
:: Mapping
if %fadeaoutputname% == 0:a:0 (
    set mapaudio=0:a:0
) else (
    set mapaudio=[%fadeaoutputname%]
)
set mapvideo=[%upscaleoutputname%]
:: Command
ffmpeg -hide_banner %hwaccelarg% -ss %starttime% -t %time% -i %1 %ainput% %encoderarg% -c:a %audioencoder% %audioencoderopts% -filter_complex "%filterinput%%filteramix%%filterfade%%filterupscale%" -map "%mapaudio%" -map "%mapvideo%" -vsync vfr -movflags +faststart "%~dpn1 (shipped).%container%"
pause