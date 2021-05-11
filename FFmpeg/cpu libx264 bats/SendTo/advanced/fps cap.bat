ffmpeg -i %1 -vf scale=1920:1080:flags=neighbor -c:v libx264 -preset fast -crf 15 -c:a copy -r 60 "%~dpn1 (capped).mp4"
pause