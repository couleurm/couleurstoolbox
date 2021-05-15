ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',fps=60,tmix=frames=2:weights='1',fps=30,mpdecimate" -preset veryslow -b:v 930k -g 480 -x264-params qpmin=18 -pass 1 -vsync vfr -an -f null NUL
echo First pass finished!
ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',fps=60,tmix=frames=2:weights='1',fps=30,mpdecimate" -preset veryslow -b:v 930k -g 480 -x264-params qpmin=18 -pass 2 -vsync vfr -c:a libfdk_aac -vbr 4 -movflags +faststart "%~dpn1 (compressed).mp4"
pause