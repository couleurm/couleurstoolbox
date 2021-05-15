ffmpeg -i %1 -vf tmix=frames=8:weights="1",fps=60,scale=3840:2160:flags=neighbor -c:v h264_amf -quality quality -qp_i 13 -qp_p 15 -qp_b 15 -c:a copy "%~dpn1 (Resampled).mp4
pause

::Change value after tmix=frames= to be the number of blur frames
::Change value after fps= to be the FPS you want to render in