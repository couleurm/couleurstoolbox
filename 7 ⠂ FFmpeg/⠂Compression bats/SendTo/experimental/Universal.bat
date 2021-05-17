@echo off
:: ONLY USE THIS FOR MEETING A TARGET FILESIZE TO UPLOAD TO SITES WHERE THERE ARE LIMITS
:: IF YOU JUST WANT TO REDUCE FILESIZE FOR STORAGE, USE OTHER SCRIPTS HERE!
:: Set size here, options:
:: Discord (8MB)
:: ClassicNitro (50MB)
:: Nitro (100MB)
:: Custom (in kbit, calculate using MB*8*1024)
set size=Discord
:: Set focus here, options:
:: Original (keeps original framerate and resolution)
:: Framerate (tries to keep 60fps)
:: Resolution (tries to keep high res)
set focus=Framerate
:: 
:: ADVANCED OPTIONS
:: Be careful, only change them if you know what they do!
::
set audioencoder=aac
set audiobitrateperc=10
set minaudiobitrate=128
set maxaudiobitrate=256
set mintotalbitrate=500
set videoencoder=libx264
set encoderopts=-g 600
set videofilters=,mpdecimate=max=6
set /p starttime=Where do you want your clip to start (in seconds): 
set /p time=How long after the start time do you want it to be: 
:: Setting target filesize (in kbit)
if %size% == ClassicNitro (set filesize=409600
) else if %size% == Nitro (set filesize=819200
) else if %size% == Discord (set filesize=65535
) else (set filesize=%size%)
:: Fix issues with overhead
set /A filesize = %filesize% - 1000
:: Calculate bitrate
set /A bitrate = %filesize% / %time%
if %bitrate% LEQ %mintotalbitrate% (
    echo ERROR: Too long to compress!
    pause && exit
)
:: Audio bitrate
set /A audiobitrate = %bitrate% / %audiobitrateperc%
if %audiobitrate% GEQ %maxaudiobitrate% (set audiobitrate=256)
if %audiobitrate% LEQ %minaudiobitrate% (set audiobitrate=128)
:: Video bitrate
set /A videobitrate = %bitrate% - %audiobitrate%
echo bitrate: %bitrate% (audio: %audiobitrate%, video: %videobitrate%)
:: Choosing encoding settings
if %videobitrate% GEQ 5000 (
    set res=1440
    set fps=60
    set preset=medium
) else if %videobitrate% GEQ 3000 (
    set res=1080
    set fps=60
    set preset=slow
) else if %videobitrate% GEQ 2000 (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=slow
    ) else (
        set res=1080
        set fps=45
        set preset=slow
    )
) else if %videobitrate% GEQ 1400 (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=slower
    ) else (
        set res=1080
        set fps=30
        set preset=slower
    )
) else if %videobitrate% GEQ 1000 (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=veryslow
    ) else (
        set res=900
        set fps=30
        set preset=veryslow
    )
) else if %videobitrate% GEQ 700 (
    if %focus% == Framerate (
        set res=540
        set fps=60
        set preset=veryslow
    ) else (
        set res=720
        set fps=30
        set preset=veryslow
    )
) else if %videobitrate% GEQ 500 (
    if %focus% == Framerate (
        set res=360
        set fps=45
        set preset=veryslow
    ) else (
        set res=720
        set fps=20
        set preset=veryslow
    )
) else (
    set res=360
    set fps=30
    set preset=veryslow
)
:: Set -vf param
if %focus% == Original (
    set filters=
) else (
    set filters=-vf "fps=%fps%,scale='-2':'min(%res%,ih)':flags=lanczos%videofilters%"
)
:: Echo settings
echo %res%p%fps%, preset %preset%
:: Run ffmpeg
ffmpeg -ss %starttime% -t %time% -i %1 %filters% -c:v %videoencoder% %encoderopts% -preset %preset% -b:v %videobitrate%k -pass 1 -vsync vfr -an -f null NUL && ffmpeg -ss %starttime% -t %time% -i %1 %filters% -c:v %videoencoder% %encoderopts% -preset %preset% -b:v %videobitrate%k -pass 2 -c:a %audioencoder% -b:a %audiobitrate%k -vsync vfr -movflags +faststart "%~dpn1 (compressed).mp4"
del ffmpeg2pass-0.log
del ffmpeg2pass-0.log.mbtree
pause