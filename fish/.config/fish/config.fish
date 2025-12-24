fish_add_path /opt/homebrew/bin
fish_vi_key_bindings

set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -gx PNPM_HOME /Users/evergosu/Library/pnpm
fish_add_path $PNPM_HOME

set -U fish_greeting

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx EDITOR nvim
set -gx FORCE_COLOR 1
set -gx LS_COLORS (vivid generate nord)

set -gx GPG_TTY (tty)

set -gx HOMEBREW_BUNDLE_FILE ~/Brewfile

starship init fish | source
