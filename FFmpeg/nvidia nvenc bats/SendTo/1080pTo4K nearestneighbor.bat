ffmpeg -i %1 -vf scale=3840:2160:flags=neighbor -c:v h264_nvenc -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51 "%~dpn1 (4K).mp4"
pause
