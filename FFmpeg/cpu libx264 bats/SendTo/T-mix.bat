ffmpeg -i %1 -vf tmix=frames=8:weights="1",fps=60 -c:v libx264 -preset fast -crf 15 -c:a copy "%~dpn1 (Resampled).mp4
pause

::Change value after tmix=frames= to be the number of blur frames
::Change value after fps= to be the FPS you want to render in