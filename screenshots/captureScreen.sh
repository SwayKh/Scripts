#!/bin/bash

location="$HOME"/Pictures/Screenshots/"$(date +'%s_grim.png')"

grim -g "$(slurp -d -o)" "$location"

cat "location" | wl-copy

notify-send "Screenshot Taken"
