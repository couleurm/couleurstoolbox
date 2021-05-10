ffmpeg -i %1 -vf tmix=frames=8,fps=fps=60,xbr=3 -c:v h264_nvenc -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51 "%~dpn1 (ready).mp4"
pause

::Instructions:

:: Change the value after tmix=frames= to the number of blurframes
:: fps=fps= to the fps you want to render in.