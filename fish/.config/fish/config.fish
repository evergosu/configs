fish_add_path /opt/homebrew/bin

set -U fish_greeting
set -Ux LC_ALL C.UTF-8
set -gx EDITOR nvim
set -gx LS_COLORS (vivid generate nord)
set -gx GPG_TTY (tty)

set fzf_directory_opts --bind 'ctrl-o:execute($EDITOR {} &> /dev/tty)'
set fzf_fd_opts --hidden --exclude=.git
set fzf_preview_dir_cmd ls

fish_vi_key_bindings

function ls --wraps exa --description 'calls exa with bunch of default params'
  exa --long --icons --color=always --all --group-directories-first --git --ignore-glob='.git' $argv
end

function tree --wraps exa --description 'calls tree version of exa'
  ls --tree $argv
end

function update --wraps brew --description 'update brew and sketchybar widget'
  brew update; brew upgrade; brew cleanup
  sketchybar --trigger brew_update
end

starship init fish | source
