ffmpeg -i %1 -vf xbr=3 -c:v h264_amf -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51 "%~dpn1 (4K).mp4"
pause

::if you change the value after XBR it'll change how much times it multiplies the resolution.