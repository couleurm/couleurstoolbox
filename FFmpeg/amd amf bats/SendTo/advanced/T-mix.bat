ffmpeg -hwaccel cuda -i %1 -vf xbr=2 -c:v hevc_amf -rc constqp -qp 20 -preset p7 -c:a copy -r 60 "%~dpn1 (Resampled).mp4"
pause

::test