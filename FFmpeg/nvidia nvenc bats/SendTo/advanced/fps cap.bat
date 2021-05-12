ffmpeg -hwaccel cuda -hwaccel_output_format cuda -threads 8 -i %1 -vf scale_cuda=1920:1080:1 -c:v hevc_nvenc -preset p7 -rc constqp -qp 18 -c:a copy -r 60 "%~dpn1 (capped).mp4"
pause