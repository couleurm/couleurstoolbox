@echo off
set size=800000
set hwaccel=auto
::
:: ADVANCED OPTIONS
:: Be careful, only change them if you know what they do!
::
set audiobitrate=160
set mintotalbitrate=500
set bitratetargetpercent=100
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
echo This version of DiscordCompressor is deprecated.
echo Use https://github.com/vladaad/discordcompressor instead.
echo It's much faster while being more convenient and higher quality.
set /p starttime=Where do you want your clip to start (in seconds): 
set /p time=How long after the start time do you want it to be: 
:: Calculate bitrate
set /A bitrate = %size% / %time%
if %bitrate% GEQ 10000 (
    set bitrate=10000
)
if %bitrate% LEQ %mintotalbitrate% (
    echo ERROR: Too long to compress! Maximum is 130 seconds.
)
:: Video bitrate
set /A videobitrate = %bitrate% - %audiobitrate%
echo bitrate: %bitrate% (audio: %audiobitrate%, video: %videobitrate%)
:: hwaccel
set hwaccel=-hwaccel %hwaccel%
:: Set -vf param
set filters=-vf "fps=60,mpdecimate,scale='-2':'min(720,ih)':flags=lanczos,format=yuv420p%videofilters%"
:: Running
echo\
echo Encoding...
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -stats %hwaccel% ^
-ss %starttime% -t %time% -i %1 ^
%filters% ^
-c:v libx264 -preset slow -b:v %videobitrate%k -pass 1 ^
-vsync vfr -an -f null NUL
echo\
echo First pass finished!
echo\
ffmpeg -loglevel warning -stats %hwaccel% ^
-ss %starttime% -t %time% -i %1 ^
%filters% ^
-c:v libx264 -preset slow -b:v %videobitrate%k -pass 2 ^
-c:a aac -b:a %audiobitrate%k ^
-vsync vfr -movflags +faststart "%~dpn1 (compressed).mp4"
:: End
echo\
echo Done!
echo\
color 0A
del ffmpeg2pass-0.log
del ffmpeg2pass-0.log.mbtree
pause