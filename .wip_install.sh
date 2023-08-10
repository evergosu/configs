#!/usr/bin/env sh

echo "Installing terminal..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Installing CLI tools..."
xcode-select --install

echo "Installing package manager..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

echo "Installing packages..."
brew bundle
codesign -fs 'yabai-cert' $(which yabai)
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

echo "Installing shell..."
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

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
brew services start sketchybar
yabai --start-service
skhd --start-service
