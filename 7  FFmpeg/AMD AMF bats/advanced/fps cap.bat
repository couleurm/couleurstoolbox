ffmpeg -i %1 -vf scale=1920:1080:flags=neighbor -c:v h264_amf -quality quality -qp_i 13 -qp_p 15 -qp_b 15 -c:a copy -r 60 "%~dpn1 (capped).mp4"
pause