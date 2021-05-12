ffmpeg -i %1 -vf xbr=3 -c:v libx264 -preset fast -crf 15 -c:a copy "%~dpn1 (4K).mp4"
pause

::if you change the value after XBR it'll change how much times it multiplies the resolution.