If these scripts don't work, update your ffmpeg and drivers. If it's not fixed by that, use preset slow instead of p7.
Use QP10 or lower if you're going to be re-encoding these in any way. If you need H264, lower QP by a bit (~2-3) and change hevc_nvenc to h264_nvenc.
Alternatively, remove "-rc constqp -qp XX" and replace it with "-tune lossless" if you want truly lossless files.
XBR is slower than nearestneighbor in these scripts!