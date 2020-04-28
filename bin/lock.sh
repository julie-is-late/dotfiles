#!/bin/bash
# redacted-moose's i3lock blurred screen inspired by
# /u/patopop007 and the blog post:
# http://plankenau.com/blog/post-10/gaussianlock

set -e

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

# Apply a blur to the image:
# The goal is to scale to a max y height of n px and then scale back to the 
# original px height. 
# Here are some imagemagick blur types
# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args


# 3.3333% = "x30", 2.5% = "x30", 5% = "x50"
### pixelated
#magick mogrify -scale "x40" -scale "$(magick identify -format "%wx%h" "$IMAGE")" "$IMAGE"
magick mogrify -scale "x40" -scale "$(magick identify -format "%wx%h" "$IMAGE")" "$IMAGE"

### blurred
#magick mogrify -scale "x40" -resize "x$(magick identify -format "%h" "$IMAGE")" "$IMAGE"

# more blurred
#-scale "x100" -blur "0x1.5" -scale
#-scale "x50" -blur "0x1.5" -scale
#-scale "x50" -blur "0x0.25" -scale

# notes about things that don't work:
# -sample -> creates just uniform noise

# finally, lock

i3lock -e -i "$IMAGE"

# =====================================
#old:
#i3lock -i Pictures/ScreenSaver/FWG_1920x1200.png -t
