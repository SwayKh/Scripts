#!/bin/bash

hyprctl dispatch exec floorp
sleep 1
hyprctl dispatch togglespecialworkspace term
sleep 0.5
hyprctl dispatch togglespecialworkspace lf
sleep 0.5
hyprctl dispatch togglespecialworkspace dots
sleep 0.5
hyprctl dispatch togglespecialworkspace monitor
sleep 1
hyprctl dispatch exec spotify-launcher
sleep 1
hyprctl dispatch exec retroarch
sleep 1
hyprctl dispatch exec obsidian
sleep 1
hyprctl dispatch exec ferdium
sleep 1
hyprctl dispatch exec webcord
