ffmpeg -i %1 -vf scale=1920:1080:flags=neighbor -pix_fmt yuv420p -c:v h264_nvenc -profile:v high -preset fast -rc vbr_hq -qmin 0 -qmax 1 -cq 51 -r 50 "%~dpn1 (capped).mp4"
pause