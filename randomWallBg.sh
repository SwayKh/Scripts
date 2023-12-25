#!/bin/bash
wall=$(command ls ~/wallpapers/Images/ | shuf -n 1)
path="/home/sumit/wallpapers/Images/$wall"
killall swaybg
cp "$path" ~/.config/wall.jpg && swaybg -m fill -i "$path" &
