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

# Get the screenshot, add the blur and lock the screen with it
# Alternate screenshot method with imagemagick. NOTE: it is much slower
#import -window root "$IMAGE"  # 1.35s
# and alternate with maim
#maim "$IMAGE"  # 0.46s

scrot -o "$IMAGE"

# Here are some imagemagick blur types
# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args

#convert "$IMAGE" -scale 1% -scale 10000% "$IMAGE"
#convert "$IMAGE" -scale 2.5% -scale 4000% "$IMAGE"
convert "$IMAGE" -scale 5% -scale 2000% "$IMAGE"
#convert "$IMAGE" -scale 10% -scale 1000% "$IMAGE"
#convert "$IMAGE" -scale 10% -blur "0x0.25" -scale 1000% "$IMAGE"
#convert "$IMAGE" -scale 5% -blur "0x1.5" -scale 2000% "$IMAGE"
#convert "$IMAGE" -scale 5% -blur "0x0.25" -resize 2000% "$IMAGE"

# finally, lock

i3lock -e -i "$IMAGE"

# =====================================
#old:
#i3lock -i Pictures/ScreenSaver/FWG_1920x1200.png -t
