#! /bin/sh

# Change wallpaper and run hellwal
"$HOME/scripts/random-swwwbg"

# Load hellwal colors to apply to borders
source "$HOME/.cache/hellwal/variables.sh"

sleep 0.5
# Apply colors to RiverWM border
riverctl border-color-focused "0x${color6}"
riverctl border-color-unfocused "0x${color1}"

sleep 0.5
# Restart Dunst with new color
"$HOME/.config/dunst/launch-dunst.sh"
