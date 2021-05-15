@echo Installing FFmpeg...
choco install ffmpeg -y
@echo FFmpeg has been successfully installed and installed to the path!
@echo If you use scripts that change directory to use FFmpeg, make sure you change them.
@echo Example, if you see C:\ffmpeg\bin\ffmpeg.exe, and it doesn't work, simply replace all that with "ffmpeg"