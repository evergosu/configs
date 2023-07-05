#!/bin/bash

lock=(
  margin=-200
  y_offset=-32
  blur_radius=0
  notch_width=0
  padding_left=0
  padding_right=0
)

unlock=(
  margin=10
  y_offset=0
  blur_radius=30
  notch_width=200
  padding_left=10
  padding_right=10
  corner_radius=11
)

case "$SENDER" in
  "lock") sketchybar --bar "${lock[@]}"
  ;;
  "unlock") sketchybar --animate sin 25 --bar "${unlock[@]}"
  ;;
esac
