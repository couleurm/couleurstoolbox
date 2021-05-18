ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',mpdecimate=max=4" -preset veryslow -b:v 1300k -g 900 -x264-params qpmin=20 -pass 1 -vsync vfr -f null NUL
echo First pass finished!
ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',mpdecimate=max=4" -preset veryslow -b:v 1300k -g 900 -x264-params qpmin=20 -pass 2 -vsync vfr -c:a libfdk_aac -vbr 4 -movflags +faststart "%~dpn1 (compressed).mp4"
pause