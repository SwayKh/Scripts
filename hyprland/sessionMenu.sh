#!/usr/bin/env bash

# Rofi dmenu mode, -i make search case-insensitive, -l is the number of line
rofi_command() {
  rofi -dmenu -i -theme-str '@import "~/scripts/rofi/power.rasi"'
}

shutdown="󰐥 | Shutdown"
reboot=" | Restart"
lock=" | Lock"
suspend="󰤄 | Suspend"
logout="󰍂 | Logout"

options="$shutdown\n$reboot\n$logout\n$suspend\n$lock"

chosen="$(echo -e "$options" | rofi_command)"
echo "$chosen"
case $chosen in
"$shutdown")
  systemctl poweroff
  ;;
"$reboot")
  systemctl reboot
  ;;
"$lock")
  # Install swaylock-effects for better configuration
  swaylock -l
  ;;
"$suspend")
  mpc -q pause
  amixer set Master mute
  systemctl suspend
  ;;
"$logout")
  # For Hyprland, Use Command for your WM/DE
  hyprctl dispatch exit

  # if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
  # 	openbox --exit
  # elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
  # 	bspc quit
  # elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
  # 	i3-msg exit
  # elif [[ "$DESKTOP_SESSION" == "xfce" ]]; then
  # 	killall xfce4-session
  # fi
  ;;
esac