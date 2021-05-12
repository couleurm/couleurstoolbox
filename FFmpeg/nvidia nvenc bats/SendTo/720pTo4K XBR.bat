ffmpeg -hwaccel cuda -threads 8 -i %1 -vf xbr=3 -c:v hevc_nvenc -preset p7 -rc constqp -qp 18 -c:a copy "%~dpn1 (4K).mp4"
pause

::if you change the value after XBR it'll change how much times it multiplies the resolution.