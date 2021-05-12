If these scripts don't work, update your ffmpeg and drivers. If it's not fixed by that or you don't want to update your drivers/ffmpeg, use preset slow instead of p7.
If you need H264, lower QP by a bit (~2-3) and change hevc_nvenc to h264_nvenc.
Alternatively, remove "-rc constqp -qp XX" and replace it with "-tune lossless" if you want truly lossless files.
FYI XBR is slower than nearestneighbor in these scripts