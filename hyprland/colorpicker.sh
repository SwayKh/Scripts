#!/bin/bash

color=$(hyprpicker)

echo -n "$color" | wl-copy

dunstify "Color: $color"
