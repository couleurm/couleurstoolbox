ffmpeg -i %1 -vf tmix=frames=8:weights="1" -c:v h264_nvenc -profile:v high -preset fast -qmin 0 -qmax 1 -cq 51  -r 60 "%~dpn1-Rendered.mp4"
cmd /k