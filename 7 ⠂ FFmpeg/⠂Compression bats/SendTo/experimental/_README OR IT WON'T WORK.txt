Don't use these if you don't know what you're doing. If you don't understand any part of this README, don't use them.

Scripts tagged as "SC" need a self-compiled version of ffmpeg with libfdk_aac (or other things if mentioned in bat itself)
Scripts tagged as "IC" (incompatible) may not play properly on mobile devices or even some desktop video players including discord's player
Scripts tagged as "SLOW" are, you guessed it, slow.

VP9, Opus and webms don't work on iOS.

Here's a short description of each bat:
IC-SLOW VP9+Opus 120s 720pVFR
Using VP9 and Opus brings a very efficient yet slow bat - VFR helps a bit with encoding times but keep in mind FPS isn't capped and this doesn't work on iOS Discord

SC x264+AAC 45s 720pVFR
Essentially the 30 second bat from non-experimental adapted for 45 second clips with better audio

SC x264+AAC 60s 720p30VFR tmix
tmixes 60 to 30fps to attempt to slightly increase compression efficiency, essentially a mix of 720p30 and 540p60 bats from non-experimental