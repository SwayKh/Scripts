#! /usr/bin/env bash

location="$HOME"/Pictures/Screenshots/"$(date +'%s_grim.png')"

grim -g "$(slurp -d)" "$location"

wl-copy <"$location"

notify-send "Screenshot Taken"
