#!/bin/bash

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
  'com.apple.keylayout.ABC')
    sketchybar --set $NAME icon.drawing=off
    ;;
  'com.apple.keylayout.Russian')
    sketchybar --set $NAME icon.drawing=on
    ;;
esac
