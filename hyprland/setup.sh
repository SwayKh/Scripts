#!/bin/bash

hyprctl dispatch exec [workspace 1 silent] firefox
sleep 1
hyprctl dispatch exec [workspace 2 silent] "foot -e nvim ~/dotfiles/"
sleep 1
hyprctl dispatch exec [workspace 3 silent] foot
sleep 1
hyprctl dispatch exec [workspace 4 silent] foot
sleep 1
hyprctl dispatch exec [workspace 5 silent] "foot -e zsh -ic lf"
sleep 1
hyprctl dispatch exec [workspace 6 silent] retroarch
