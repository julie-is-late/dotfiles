#!/bin/bash
# redacted-moose's i3lock blurred screen inspired by
# /u/patopop007 and the blog post:
# http://plankenau.com/blog/post-10/gaussianlock

# Timings are on an Intel i7-2630QM @ 2.00GHz

# Dependencies:
# imagemagick
# i3lock
# scrot (optional but default)

IMAGE="$(mktemp /tmp/i3lock.XXXXXXXX.png)"
# SCREENSHOT="maim $IMAGE" # 0.46s

# Alternate screenshot method with imagemagick. NOTE: it is much slower
# SCREENSHOT="import -window root $IMAGE" # 1.35s

# Here are some imagemagick blur types
# Uncomment one to use, if you have multiple, the last one will be used

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
#BLURTYPE="5x2" # 3.80s
#BLURTYPE="2x8" # 2.90s
#BLURTYPE="2x3" # 2.92s
#BLURTYPE="0x20"

# Get the screenshot, add the blur and lock the screen with it
#maim "$IMAGE"
scrot -o "$IMAGE"

#convert "$IMAGE" -gaussian-blur $BLURTYPE "$IMAGE"
#convert "$IMAGE" -blur $BLURTYPE "$IMAGE"
#convert "$IMAGE" -scale 5% -scale 2000% "$IMAGE"

convert "$IMAGE" -scale 5% -scale 2000% -blur "0x7" "$IMAGE"

i3lock -e -i "$IMAGE"

# =====================================
#old:
#i3lock -i Pictures/ScreenSaver/FWG_1920x1200.png -t
