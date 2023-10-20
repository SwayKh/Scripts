#!/bin/bash
wall=$(command ls ~/wallpapers/Images/ | shuf -n 1)
path="/home/sumit/wallpapers/Images//$wall"

cp "$path" ~/.config/wall.jpg && swaybg -m fill -i "$path" &
