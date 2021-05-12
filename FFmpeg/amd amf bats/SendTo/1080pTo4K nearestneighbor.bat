ffmpeg -i %1 -vf scale=3840:2160:flags=neighbor -c:v h264_amf -quality quality -qp_i 13 -qp_p 15 -qp_b 15 -c:a copy "%~dpn1 (4K).mp4"
pause
