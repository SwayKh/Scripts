#! /usr/bin/env bash

location="$HOME"/Pictures/Screenshots/"$(date +'%s_grim.png')"

grim "$location"

wl-copy <"$location"

notify-send -e "Screenshot Taken"
