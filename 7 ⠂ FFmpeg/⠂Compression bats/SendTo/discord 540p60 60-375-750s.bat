ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(540,ih):flags=lanczos',fps=60" -preset veryslow -b:v 955k -g 720 -x264-params qpmin=18 -pass 1 -f null NUL
echo First pass finished!
ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(540,ih):flags=lanczos',fps=60" -preset veryslow -b:v 955k -g 720 -x264-params qpmin=18 -pass 2 -c:a aac -b:a 128k -movflags +faststart "%~dpn1 (compressed).mp4"
pause