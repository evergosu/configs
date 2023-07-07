#!/bin/zsh

echo "Installing vim..."
bash <(curl -s https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz)
xattr -c ~/Downloads/nvim-macos.tar.gz
tar xzvf ~/Downloads/nvim-macos.tar.gz
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

echo "Installing CLI tools..."
xcode-select --install

echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized

brew install --cask wezterm-nightly
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install vlc
brew install zoom
brew install neofetch
brew install nnn
brew install mas
brew install jq
brew install gh
brew install dooit --HEAD
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install zsh-vi-mode
brew install sketchybar
brew install sf-symbols
brew install skhd
brew install yabai --HEAD

codesign -fs 'yabai-cert' $(which yabai)

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

source $HOME/.zshrc

echo "Installing Mac App Store apps..."
mas install 1451685025 # Wireguard

echo "Changing MacOS defaults..."
defaults write com.apple.dock autohide -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true
# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock missioncontrol-animation-duration -float 0.1
# Disable finder animations
# defaults write com.apple.finder DisableAllAnimations -bool true

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Start Services
echo "Starting Services (please, grant permissions)..."
brew services start skhd
brew services start yabai
brew services start sketchybar
