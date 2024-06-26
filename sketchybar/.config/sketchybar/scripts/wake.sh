#!/bin/bash

source "$HOME/.config/sketchybar/properties.sh"

lock=(
  margin=-200
  y_offset=-33
  notch_width=0
  padding_left=0
  padding_right=0
)

unlock=(
  margin=0
  y_offset=0
  notch_width=200
  padding_left=$PADDING
  padding_right=$PADDING
)

case "$SENDER" in
  "lock") sketchybar --bar "${lock[@]}"
  ;;
  "unlock") sketchybar --animate sin 25 --bar "${unlock[@]}"
  ;;
esac
