ffmpeg -i %1 -vf scale=1920:1080:flags=neighbor -c:v h264_nvenc -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51 -r 60 "%~dpn1 (capped).mp4"
pause