function ls --wraps exa --description 'calls exa with bunch of default params'
  exa --long --icons --color=always --all --group-directories-first --git --ignore-glob='.git' $argv
end
