# backlight
brightnessctl -d intel_backlight s 1
# power button
brightnessctl -d tpacpi::power s 0
# keeb backlight
brightnessctl -d tpacpi::kbd_backlight s 0
# keeb mute
brightnessctl -d platform::mute s 0
# keeb mic mute
brightnessctl -d platform::micmute s 0
