#!/bin/bash

rofi \
    -show windowcd \
    -dpi 136 \
    -kb-row-down "Alt+Tab,Alt+Down,Down" \
    -kb-row-up "Alt+Up,Up,Alt+ISO_Left_Tab" \
    -kb-accept-entry "!Alt-Tab,Return" \
    -kb-cancel "Alt+Escape,Escape" \
    -selected-row 2
