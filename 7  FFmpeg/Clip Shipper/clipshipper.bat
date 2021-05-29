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
set /p audiofile=What audio file should be added? no to keep original audio: 
set /p audiostarttime=Where should the audio file start?: 
set /p starttime=Where do you want your clip to start in seconds: 
set /p time=How long after the start time do you want it to be: 
set /p upscaleto4k=Do you want to upscale to 4K? yes/no, default yes: 
set /p fadetime=How long do you want the clip to fade in and out in seconds? default 0: 
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
        set encoderopts=%encoderopts% -qp_i %quality% -qp_p %quality% -qp_b %quality% %globaloptions%
    ) else (
        set encoderopts=%encoderopts% %qualityarg% %quality% %globaloptions%
    )
) else (
    set encoderopts=%forcedencoderopts%
)
echo encoptsgood
:: FFmpeg command creation
:: Input filters
set filterinput=[0:v]format=yuv420p[fadeinput];
:: Upscaling to 4K
if %upscaleto4k% == yes (
    set filterupscale=[scaleinput]scale=-2:2160:flags=lanczos[upscaled];
) else (
    set filterupscale=[scaleinput][upscaled];
)
:: Fading
set /A endfadestarttime=%time%-%fadetime%
set filterfade=[mixedaudio]afade=t=in:st=0:d=%fadetime%,afade=t=out:st=%endfadestarttime%:d=%fadetime%[finalaudio];[fadeinput]fade=t=in:st=0:d=%fadetime%,fade=t=out:st=%endfadestarttime%:d=%fadetime%[scaleinput];
:: Audio mix
if %audiofile% == no (
    set filteramix=[amixinput][mixedaudio];
) else (
    set filteramix=[0:a][1:a]amix=tracks=2[mixedaudio];
)
:: Audio input
if %audiofile% == no (
) else (
    set ainput=-ss %audiostarttime% -t %time% -i %audiofile%
)
:: Command
echo ffmpeg %hwaccelarg% -ss %starttime% -t %time% %ainput% %encoderopts% -filter_complex '%filterinput%%filteramix%%filterfade%%filterupscale%' -map "[upscaled]" -map "[finalaudio]" -vsync vfr -movflags +faststart "%~dpn1 (compressed).%container%"