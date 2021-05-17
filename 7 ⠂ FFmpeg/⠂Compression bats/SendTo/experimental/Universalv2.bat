@echo off
:: Set size here, options:
:: Discord (8MB)
:: ClassicNitro (50MB)
:: Nitro (100MB)
:: Custom (in kbit, calculate using MB*8*1024)
set size=696969
set /p starttime=Where do you want your clip to start (in seconds): 
set /p time=How long after the start time do you want it to be: 
:: Setting target filesize (in kbit)
if %size% == ClassicNitro (set filesize=409600
) else if %size% == Nitro (set filesize=819200
) else if %size% == Discord (set filesize=65535
) else (set filesize=%size%)
echo %filesize%
if %time% GEQ 60 (
    set res=540
    set fps=60
    set preset=veryslow
    set extravf=,tmix=frames=2,fps=30,mpdecimate=max=2
    color 0c
    echo .
    echo ----------------------------------
    echo WARNING! This will likely look bad
    echo ----------------------------------
    pause
    color 07
) else if %time% GEQ 45 (
    set res=540
    set fps=60
    set preset=veryslow
    set extravf=,mpdecimate=max=2
) else if %time% GEQ 30 (
    set res=720
    set fps=60
    set preset=slow
) else if %time% GEQ 15 (
    set res=1080
    set fps=60
    set preset=slow
) else (
    set res=1440
    set fps=60
    set preset=medium
)
echo Using %res%p%fps% with %preset% preset
pause