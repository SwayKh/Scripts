#!/bin/bash

location="$HOME"/Pictures/Screenshots/"$(date +'%s_grim.png')"

grim "$location"

cat "location" | wl-copy

notify-send -e "Screenshot Taken"
