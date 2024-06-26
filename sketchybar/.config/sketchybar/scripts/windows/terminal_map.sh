#!/usr/bin/env bash

function __terminal_map() {
  if [[ "$1" == "kitty" ]]; then
    title=$(yabai -m query --windows --window $2 | jq -rc '.title')

    case $title in
      "Neovim" | "neovim" | "nvim"*)
        icon_result=":neovim:"
        ;;
    esac
  fi
}
