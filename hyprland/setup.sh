#!/bin/bash

hyprctl dispatch exec [workspace 1 silent] firefox
sleep 1
hyprctl dispatch exec [workspace 2 silent] "foot -e nvim"
sleep 1
hyprctl dispatch exec [workspace 3 silent] "foot -e lf"
sleep 1
hyprctl dispatch exec [workspace 4 silent] foot
sleep 1
hyprctl dispatch exec [workspace 9 silent] obsidian
