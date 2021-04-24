ffmpeg -i %1 -preset fast -c:v h264_nvenc -profile:v high -rc constqp -qp 0 -vf tmix=frames=16:weights="1" -c:a copy -r 30 %1-rendered.mp4
pause