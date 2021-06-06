@echo off
:: ONLY USE THIS FOR MEETING A TARGET FILESIZE TO UPLOAD TO SITES WHERE THERE ARE LIMITS
:: IF YOU JUST WANT TO REDUCE FILESIZE FOR STORAGE, USE OTHER SCRIPTS HERE!
:: Set size here, options:
:: Discord (8MB)
:: ClassicNitro (50MB)
:: Nitro (100MB)
:: Custom (in kbit, calculate using MB*8*1024)
set asksize=true
set size=Discord
:: Set focus here, options:
:: Original (keeps original framerate and resolution)
:: Framerate (tries to keep 60fps)
:: Resolution (tries to keep high res)
set askfocus=true
set focus=Framerate
:: Hardware acceleration
:: Due to hardware encoders being not very good for this this script will still use libx264 for encoding.
:: Available options (same as in ffmpeg -hwaccel):
:: cpu (none)
:: cuda (nvidia)
:: d3d11va (everything)
:: any other hwaccel
set hwaccel=cuda
::
:: ADVANCED OPTIONS
:: Be careful, only change them if you know what they do!
::
set audioencoder=aac
set audiobitratepercent=10
set audioencoderoptions=
set minaudiobitrate=128
set maxaudiobitrate=256
set mintotalbitrate=500
set bitratetargetpercent=100
set container=mp4
set videoencoder=libx264
set forcepreset=no
set twopasscommand=-pass 
set presetcommand=-preset 
set encoderopts=-g 600
set videofilters=,mpdecimate=max=6
:: Bitrate targets
set /A target1 = 50 * %bitratetargetpercent%
set /A target2 = 30 * %bitratetargetpercent%
set /A target3 = 20 * %bitratetargetpercent%
set /A target4 = 14 * %bitratetargetpercent%
set /A target5 = 10 * %bitratetargetpercent%
set /A target6 = 7 * %bitratetargetpercent%
set /A target7 = 5 * %bitratetargetpercent%
:: Input check
color 0f
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: Length questions
set /p starttime=Where do you want your clip to start (in seconds): 
set /p time=How long after the start time do you want it to be: 
:: Focus and size questions
:: Disclaimer
set askdisclaimer=false
if %askfocus% == true (set askdisclaimer=true)
if %asksize% == true (set askdisclaimer=true)
if %askdisclaimer% == true (echo To disable these questions, set askfocus and asksize to false.)
:: Focus
if %askfocus% == true (
    cls
    echo What do you want to focus on?
    echo Framerate - keep FPS as high as possible
    echo Resolution - keep resolution as high as possible
    echo Original - try to keep original FPS and resolution
    set /p focus=
)
:: Size
if %asksize% == true (
    cls
    echo What filesize do you want to target?
    echo Discord - 8MB
    echo ClassicNitro - 50MB
    echo Nitro - 100MB
    set /p size=
)
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
set /A audiobitrate = %bitrate% / %audiobitratepercent%
if %audiobitrate% GEQ %maxaudiobitrate% (set audiobitrate=%maxaudiobitrate%)
if %audiobitrate% LEQ %minaudiobitrate% (set audiobitrate=%minaudiobitrate%)
:: Video bitrate
set /A videobitrate = %bitrate% - %audiobitrate%
echo bitrate: %bitrate% (audio: %audiobitrate%, video: %videobitrate%)
:: Choosing encoding settings
if %videobitrate% GEQ %target1% (
    set res=1440
    set fps=60
    set preset=medium
    set qpmin=20
) else if %videobitrate% GEQ %target2% (
    set res=1080
    set fps=60
    set preset=slow
    set qpmin=18
) else if %videobitrate% GEQ %target3% (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=slow
        set qpmin=18
    ) else (
        set res=1080
        set fps=45
        set preset=slow
        set qpmin=18
    )
) else if %videobitrate% GEQ %target4% (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=slower
        set qpmin=20
    ) else (
        set res=1080
        set fps=30
        set preset=slower
        set qpmin=18
    )
) else if %videobitrate% GEQ %target5% (
    if %focus% == Framerate (
        set res=720
        set fps=60
        set preset=veryslow
        set qpmin=21
    ) else (
        set res=900
        set fps=30
        set preset=veryslow
        set qpmin=18
    )
) else if %videobitrate% GEQ %target6% (
    if %focus% == Framerate (
        set res=540
        set fps=60
        set preset=veryslow
        set qpmin=20
    ) else (
        set res=720
        set fps=30
        set preset=veryslow
        set qpmin=19
    )
) else if %videobitrate% GEQ %target7% (
    if %focus% == Framerate (
        set res=360
        set fps=45
        set preset=veryslow
        set qpmin=17
    ) else (
        set res=720
        set fps=20
        set preset=veryslow
        set qpmin=20
    )
) else (
    set res=360
    set fps=30
    set preset=veryslow
    set qpmin=0
)
:: hwaccel
if %hwaccel% == cpu (
    set hwaccel=
) else (
    set hwaccel=-hwaccel %hwaccel%
)
:: Preset force
if %forcepreset% == no (
    echo Not forcing preset
) else (
    set preset=%forcepreset%
)
:: Set -vf param
if %focus% == Original (
    set filters=-vf format=yuv420p%videofilters%
) else (
    set filters=-vf "fps=%fps%,scale='-2':'min(%res%,ih)':flags=lanczos,format=yuv420p%videofilters%"
)
:: Only do -x264-params if it is x264
if %videoencoder% == libx264 (
    set qpmincmd=-x264-params qpmin=%qpmin%
)
:: Running
echo\
echo Encoding...
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -stats %hwaccel% ^
-ss %starttime% -t %time% -i %1 ^
%filters% ^
-c:v %videoencoder% %encoderopts% %presetcommand%%preset% -b:v %videobitrate%k %qpmincmd% %twopasscommand%1 ^
-vsync vfr -an -f null NUL
echo\
echo First pass finished!
echo\
ffmpeg -loglevel warning -stats %hwaccel% ^
-ss %starttime% -t %time% -i %1 ^
%filters% ^
-c:v %videoencoder% %encoderopts% %presetcommand%%preset% -b:v %videobitrate%k %qpmincmd% %twopasscommand%2 ^
-c:a %audioencoder% %audioencoderoptions%-b:a %audiobitrate%k ^
-vsync vfr -movflags +faststart "%~dpn1 (compressed).%container%"
:: End
echo\
echo Done!
echo\
color 0A
del ffmpeg2pass-0.log
del ffmpeg2pass-0.log.mbtree
pause