# basic load
AVISource("filename.avi")
# with no sound
AVISource("filename.avi", false)
# force as x264
# see following page for other codec
# http://www.fourcc.org/index.php?http%3A//www.fourcc.org/codecs.php
AVISource("filename.avi", fourCC="X264")

# load sound
WAVSource("filename.wav")

# using DirectShowSource
DirectShowSource("filename.avi")
DirectShowSource("filename.avi", audio=false)
DirectShowSource("filename.avi", fps=29.970, convertfps=true)

# for x264
ConvertToYV12

# resize
Lanczos4Resize(512, 384)

# trim
# from 0 to 599 frame
Trim(0, -600)
# from 600 to end
Trim(600, 0)
