ffmpeg -i %1 -vf tmix=frames=8:weights="1" -c:v h264_nvenc -preset slow -r 60 "%~dpn1 (Resampled).mp4
pause

::Change value after tmix=frames= to be the number of blur frames
::Change value after -r to be the FPS you want to render in