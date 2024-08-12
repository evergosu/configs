function update --wraps brew --description 'update brew and sketchybar widget'
  brew update; brew upgrade; brew cleanup
  brew upgrade neovim --fetch-HEAD
  sketchybar --trigger brew_update
end
