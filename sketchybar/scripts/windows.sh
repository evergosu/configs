#!/bin/bash

source "$HOME/.config/sketchybar/sketchybarrc"

render_windows() {
  local IFS=$'\n'

  WINDOWS=($(yabai -m query --windows | jq -rc 'sort_by(.space, .app, ."stack-index") | .[] | .id, .app, ."stack-index"'))

  unset IFS

  for ((i=0; i<${#WINDOWS[@]}; i+=3)); do
    props=("${WINDOWS[@]:$i:3}")

    ID=${props[0]}
    APP=${props[1]}
    INDEX=${props[2]}
    PADDING_LEFT=$([[ $INDEX -lt 2 ]] && echo ${defaults[11]#*=} || echo -7)

    sketchybar --add        item        window.$ID left                              \
               --set        window.$ID  script="$SCRIPTS/windows.sh"                 \
                                        icon="$($SCRIPTS/icon_map.sh "$APP")"        \
                                        icon.font="sketchybar-app-font:Regular:16.0" \
                                        background.padding_left=$PADDING_LEFT        \
                                        background.y_offset=-32                      \
                                        label.drawing=off                            \
               --subscribe  window.$ID  front_app_switched                           \
                                        window_focused
  done

  sketchybar   --add        bracket     windows '/window\..*/'     \
               --set        windows     script="$SCRIPTS/windows.sh"
               # --subscribe windows         windows_changed
               # TODO: ADD AND DESTROY EVENTS AND HANDLERS HERE
}

highlight_selected() {
  BACKGROUND_COLOR=${defaults[10]#*=}
  OFFSET=-${bar[0]#*=}

  SID=$(yabai -m query --windows --window | jq .id)

  if [[ "$NAME" == *"$SID"* ]]; then
    BACKGROUND_COLOR=$NORD_FROST_3
    OFFSET=0
  fi

  sketchybar --animate tanh  30                          \
             --set     $NAME background.y_offset=$OFFSET \
                             background.color=$BACKGROUND_COLOR
}

case "$SENDER" in
  "window_focused" | "front_app_switched") highlight_selected
  ;;
esac
