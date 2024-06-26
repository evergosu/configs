#!/bin/bash

source "$HOME/.config/sketchybar/properties.sh"

COUNT=$(brew outdated | wc -l | tr -d ' ')

case "$COUNT" in
  [2-9][0-9]) COLOR=$COLOR_BREW_CRITICAL ;;
  1[0-9])     COLOR=$COLOR_BREW_DANGER ;;
  [6-9])      COLOR=$COLOR_BREW_FINE ;;
  [1-5])      COLOR=$COLOR_BREW_LOW ;;
  0)          COLOR=$COLOR_BREW_ZERO ;;
esac

sketchybar --set $NAME icon.color=$COLOR
