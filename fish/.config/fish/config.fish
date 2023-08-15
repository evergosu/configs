fish_add_path /opt/homebrew/bin
fish_vi_key_bindings

set -U fish_greeting

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx EDITOR nvim
set -gx LS_COLORS (vivid generate nord)

set -gx GPG_TTY (tty)

set -gx HOMEBREW_BUNDLE_FILE ~/Brewfile

starship init fish | source
