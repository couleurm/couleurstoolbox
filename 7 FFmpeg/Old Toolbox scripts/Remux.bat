@echo off
:: Options
set container=mp4
:: Input check
color 0f
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: Running
echo\
echo Remuxing...
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -i %1 ^
-c copy -map 0 -strict -2 ^
-movflags +faststart "%~dpn1 (remuxed).%container%"
:: End
echo\
echo Done!
echo\
color 0A
pause