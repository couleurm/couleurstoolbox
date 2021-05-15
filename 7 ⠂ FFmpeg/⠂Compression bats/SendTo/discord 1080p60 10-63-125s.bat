ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(1080,ih):flags=lanczos',fps=60" -preset medium -b:v 6340k -g 300 -x264-params qpmin=20 -pass 1 -f null NUL
echo First pass finished!
ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(1080,ih):flags=lanczos',fps=60" -preset medium -b:v 6340k -g 300 -x264-params qpmin=20 -pass 2 -c:a aac -b:a 192k -movflags +faststart "%~dpn1 (compressed).mp4"
pause