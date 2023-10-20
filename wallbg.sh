#!/bin/bash
cp "$1" ~/.config/wall.jpg && swaybg -m fill -i "$1" &
