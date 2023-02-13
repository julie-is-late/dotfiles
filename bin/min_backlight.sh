# power button
brightnessctl -d tpacpi::power s 0
# keeb backlight
brightnessctl -d tpacpi::kbd_backlight s 0
# keeb mute
brightnessctl -d platform::mute s 0
# keeb mic mute
brightnessctl -d platform::micmute s 0

#!/bin/bash

key="org.gnome.desktop.a11y.applications screen-magnifier-enabled"
current=$(gsettings get $key)

if [ "$current" == "true" ]; then
    gsettings set $key false
else
    # filter values
    gsettings set org.gnome.desktop.a11y.magnifier brightness-red -0.55
    gsettings set org.gnome.desktop.a11y.magnifier brightness-green -0.55
    gsettings set org.gnome.desktop.a11y.magnifier brightness-blue -0.55
    gsettings set org.gnome.desktop.a11y.magnifier color-saturation 0.10
    # disable zoom
    gsettings set org.gnome.desktop.a11y.magnifier mag-factor 1.0
    # color filter
    gsettings set $key true
    # backlight
    brightnessctl -d intel_backlight s 1
fi
