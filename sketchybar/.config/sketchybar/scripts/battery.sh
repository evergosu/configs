#!/bin/bash

source "$HOME/.config/sketchybar/properties.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
ICON_COLOR=$COLOR_ICON_BATTERY_LOW

if [[ "$CHARGING" != "" ]]; then
  ICON_COLOR=$COLOR_ICON_BATTERY_CHARGE
fi

if [ "$PERCENTAGE" = "" ] || [ "$PERCENTAGE" -gt 20 ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" icon.color=$ICON_COLOR drawing=on
fi
