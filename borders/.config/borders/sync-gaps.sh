#!/usr/bin/env sh

state=$(yabai -m query --displays --display | jq -re .label)

if [[ $state == "on" ]]
then
  yabai -m space --toggle gap;
  yabai -m space --toggle padding;
  borders width=0;
  yabai -m display --label off
else
  yabai -m space --toggle gap;
  yabai -m space --toggle padding;
  borders width=8;
  yabai -m display --label on
fi
