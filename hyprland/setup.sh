#!/bin/bash

hyprctl dispatch exec [workspace 1 silent] firefox 
sleep 1
hyprctl dispatch exec [workspace 2 silent] code
sleep 1
hyprctl dispatch exec [workspace 3 silent] "footclient -e lf"
sleep 1
hyprctl dispatch exec [workspace 4 silent] footclient
sleep 1
hyprctl dispatch exec [workspace 9 silent] obsidian
