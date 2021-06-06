@echo off
echo\
echo Encoding...
echo\
color 06
ffmpeg -loglevel warning -stats -i %1 ^
-vf "scale=-2:'min(ih/2,720):flags=neighbor" ^
-c:v libx264-tune fastdecode -preset veryfast -g 60 -x264-params bframes=0 -crf 18 -forced-idr 1 -strict -2 ^
-maxrate 100M -bufsize 10M -c:a copy "%~dpn1 (proxy).mp4"
echo\
echo Done!
echo\
color 0A
pause