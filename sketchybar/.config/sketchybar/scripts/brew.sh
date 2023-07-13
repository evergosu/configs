#!/bin/bash

source "$HOME/.config/sketchybar/sketchybarrc"

COUNT=$(brew outdated | wc -l | tr -d ' ')

case "$COUNT" in
  [2-9][0-9]) COLOR=$NORD_AURORA_1 ;;
  1[0-9])     COLOR=$NORD_AURORA_2 ;;
  [6-9])      COLOR=$NORD_AURORA_3 ;;
  [1-5])      COLOR=$NORD_AURORA_5 ;;
  0)          COLOR="${defaults[10]#*=}"
esac

sketchybar --set $NAME background.color=$COLOR
