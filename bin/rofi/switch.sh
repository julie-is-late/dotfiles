#!/bin/bash

rofi \
    -show window \
    -modi window \
    -matching fuzzy \
    -kb-row-down "Alt+Tab,Alt+Down,Down" \
    -kb-row-up "Alt+Up,Up,Alt+ISO_Left_Tab,ISO_Left_Tab" \
    -kb-accept-entry "!Alt-Tab,Return" \
    -kb-cancel "Alt+Escape,Escape" \
    -selected-row 2 \
    &
sleep 0.15
#xdotool key Down
