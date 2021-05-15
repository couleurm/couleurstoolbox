ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',fps=60" -preset slow -b:v 2040k -g 600 -x264-params qpmin=20 -pass 1 -f null NUL
echo First pass finished!
ffmpeg -i %1 -c:v libx264 -vf "scale='-2':'min(720,ih):flags=lanczos',fps=60" -preset slow -b:v 2040k -g 600 -x264-params qpmin=20 -pass 2 -c:a aac -b:a 128k -movflags +faststart "%~dpn1 (compressed).mp4"
::scale='-2' = automatically sets width to a multiple of 2
::min(720,ih) = sets video height to 720p or lower
::flags=lanczos = uses lanczos scaling
::fps=60 = force sets fps to 60
::preset slow = anything faster is not worth using for 720p especially with lower bitrates
::g 600 = highers keyframe int, minor quality boost in MC and major quality boost in osu! content (since this is bitrate limited)
::-x264-params qpmin=20 = sets easy to encode clips to use QP20 (sadly crfmin doesn't exist) instead of going to stupid qualities
::c:a aac & b:a 128k = would use libfdk_aac but it's non-free/LGPL only, can't do c:a copy since it would go over target most likely
::movflags +faststart = better for streaming over internet
pause