#!/bin/bash

source "$HOME/.config/sketchybar/sketchybarrc"

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
  'com.apple.keylayout.ABC')
    ICON=$ENGLISH
    COLOR="${defaults[10]#*=}"
    ;;
  'com.apple.keylayout.Russian')
    ICON=$RUSSIAN
    COLOR=$NORD_AURORA_5
    ;;
esac

sketchybar --set $NAME icon=$ICON background.color=$COLOR
