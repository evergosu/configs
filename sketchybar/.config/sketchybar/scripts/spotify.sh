#!/bin/bash

source "$HOME/.config/sketchybar/properties.sh"

MAX_LENGTH=$MAX_CHAR_LENGTH_PLAYER
HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))

update_track() {
  PLAYER_STATE=$(echo "$INFO" | jq -r '.["Player State"]')

  if [ $PLAYER_STATE = "Playing" ]; then
    TRACK="$(echo "$INFO" | jq -r .Name)"
    ARTIST="$(echo "$INFO" | jq -r .Artist)"

    TRACK_LENGTH=${#TRACK}
    ARTIST_LENGTH=${#ARTIST}

    if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
      if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
        # If MAX_LENGTH is odd, HALF_LENGTH is calculated with an extra space, so give it an extra char.
        TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
        ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"
      elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
        # Else if only the track is too long, cut it by the difference of the max length and artist length.
        TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}…"
      elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
        ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}…"
      fi
    fi

    sketchybar --set $NAME label="${ARTIST} - ${TRACK}" label.color=$COLOR_LABEL_PLAYER_ON label.drawing=on
  elif [ $PLAYER_STATE = "Paused" ]; then
    sketchybar --set $NAME label.color=$COLOR_LABEL_PLAYER_OFF
  elif [ $PLAYER_STATE = "Stopped" ]; then
    sketchybar --set $NAME label.color=$COLOR_LABEL_PLAYER_OFF label.drawing=off
  else
    sketchybar --set $NAME label.color=$COLOR_LABEL_PLAYER_OFF
  fi
}

case "$SENDER" in
  "mouse.clicked")
    osascript -e 'tell application "Spotify" to playpause'
    ;;
  *)
    update_track
    ;;
esac
