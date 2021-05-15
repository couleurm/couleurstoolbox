ffmpeg -i %1 -c:v libx264 -vf "fps=30,scale='-2':'min(720,ih):flags=lanczos'" -preset veryslow -b:v 955k -g 480 -x264-params qpmin=18 -pass 1 -f null NUL
ffmpeg -i %1 -c:v libx264 -vf "fps=30,scale='-2':'min(720,ih):flags=lanczos'" -preset veryslow -b:v 955k -g 480 -x264-params qpmin=18 -pass 2 -c:a aac -b:a 128k -movflags +faststart "%~dpn1 (compressed).mp4"
del ffmpeg2pass-0.log
del ffmpeg2pass-0.log.mbtree
pause