ffmpeg -i %1 -vf scale=3840:2160:flags=neighbor -c:v libx264 -preset fast -crf 15 -c:a copy "%~dpn1 (4K).mp4"
pause