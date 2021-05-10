ffmpeg -i %1 -vf tmix=frames=8,fps=fps=60,scale=3840:2160:flags=neighbor -c:v h264_amf -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51 "%~dpn1 (ready).mp4"
pause

::T-mix instructions:

:: Change the value after tmix=frames= to the number of blurframes
:: fps=fps= to the fps you want to render in.