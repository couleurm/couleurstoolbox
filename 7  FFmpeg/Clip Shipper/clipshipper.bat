@echo off
:: Hardware acceleration
:: Available options (same as in ffmpeg -hwaccel):
:: cpu (none)
:: NVIDIA (NVDEC/ENC)
:: AMD (d3d11va+AMF)
:: Intel (d3d11va+QSV)
:: any other hwaccel
:: Available codecs:
:: HEVC
:: H264
::
set hwaccel=cpu
set codec=H264
::
:: ADVANCED OPTIONS
:: Be careful, only change them if you know what they do!
::
set audioencoder=libopus
set audioencoderopts=-b:a 320k
set container=mkv
set forcepreset=no
set presetcommand=-preset 
set encoderopts=-g 900
set forceencoderopts=no
set customvideofilters=,mpdecimate=max=6