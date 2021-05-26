ffmpeg -hwaccel cuda -i %1 -vf scale=3840:2160:flags=neighbor -c:v hevc_nvenc -preset p7 -rc constqp -qp 18 -c:a copy "%~dpn1 (4K).mp4"
pause