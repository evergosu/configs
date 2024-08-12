#!/bin/bash

source "$HOME/.config/sketchybar/properties.sh"
source "$HOME/.config/sketchybar/scripts/icons.sh"
source "$HOME/.config/sketchybar/scripts/windows/terminal_map.sh"

highlight_current_window() {
  WINDOWS=($(sketchybar --query windows | jq -rec ".bracket | @sh" | tr -d \'))
  CURRENT_ID=$(yabai -m query --windows --window | jq .id)

  for ((i=0; i<${#WINDOWS[@]}; i+=1)); do
    COLOR=$([[ ${WINDOWS[$i]} == "window.$CURRENT_ID" ]] && echo $COLOR_ICON_HIGHLIGHT || echo $COLOR_ICON)

    sketchybar --animate tanh 5 --set ${WINDOWS[$i]} icon.color=$COLOR
  done
}

render_windows() {
  if _=$(sketchybar --query windows); then
    sketchybar --remove '/window\..*/'
    sketchybar --remove windows
  fi

  local IFS=$'\n'

  WINDOWS=($(yabai -m query --windows | jq -rc 'sort_by(.space, .app, ."stack-index") | .[] | .id, .app, ."stack-index"'))

  unset IFS

  for ((i=0; i<${#WINDOWS[@]}; i+=3)); do
    props=("${WINDOWS[@]:$i:3}")

    ID=${props[0]}
    APP=${props[1]}
    INDEX=${props[2]}
    STACK_PADDING=$( [[ $INDEX -lt 2 ]] && echo $PADDING || echo -$PADDING )
    PADDING_LEFT=$( (( i == 0 )) && echo 0 || echo $STACK_PADDING )

    __icon_map "${APP}"
    __terminal_map "${APP}" "${ID}"

    sketchybar --add item       window.$ID left                                \
               --set window.$ID icon="${icon_result}"                          \
                                       background.padding_left=$PADDING_LEFT   \
                                       background.color=$COLOR_ICON_BACKGROUND \
                                       label.drawing=off
  done

  sketchybar --add bracket windows '/window\..*/'

 highlight_current_window
}

case "$SENDER" in
  "space_windows_change")
    if [[ "$(yabai -m query --spaces --space | jq .index)" = "$(echo $INFO | jq ".space")" ]]; then
      render_windows;
    fi
    exit;;
  "window_stacked") render_windows; exit;;
  "window_focused" | "front_app_switched") highlight_current_window; exit;;
esac
