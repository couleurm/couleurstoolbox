@echo off
:: Options
set container=mp4
set weights='1 1'
:: Input check
color 0f
if %1check == check (
    echo ERROR: no input file
    echo Drag this .bat into the SendTo folder - press Windows + R and type in shell:sendto
    echo After that, right click on your video, drag over to Send To and click on this bat there.
    pause
    exit
)
:: Warning
echo Keep in mind that this script only merges the first two audio tracks.
:: Running
echo\
echo Merging...
echo\
color 06
:: FFmpeg
ffmpeg -loglevel warning -stats -i %1 ^
-c:v copy -c:a libopus -b:a 384k ^
-filter_complex "[0:a:0][0:a:1]amix=inputs=2:weights=%weights%[audio]" ^
-map 0:v -map "[audio]" ^
-movflags +faststart "%~dpn1 (merged).%container%"
:: End
echo\
echo Done!
echo\
color 0A
pause