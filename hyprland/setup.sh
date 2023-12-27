#!/bin/bash

hyprctl dispatch exec [workspace 1 silent] firefox
sleep 1
hyprctl dispatch exec [workspace 2 silent] "wezterm -e nvim"
sleep 1
hyprctl dispatch exec [workspace 3 silent] "wezterm -e lf"
sleep 1
hyprctl dispatch exec [workspace 4 silent] wezterm
sleep 1
hyprctl dispatch exec [workspace 9 silent] obsidian
