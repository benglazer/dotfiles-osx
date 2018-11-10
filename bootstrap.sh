#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Install osx-dotfiles on a new system.
# Assumes nothing is properly installed.

# Configuration
DOTFILES_ROOT="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/benglazer/dotfiles-osx.git"

# Store original working dir
pushd . > /dev/null

install_dotfiles() {
    echo -e "\tInstalling stow"
    brew install stow

    echo -e "\tPulling down dotfiles repo"
    git clone "$DOTFILES_REPO" "$DOTFILES_ROOT"

    echo -e "\tInstalling dotfiles via stow"
    mkdir -pv "$DOTFILES_ROOT"
    cd "$DOTFILES_ROOT"
    stow bash git vim
}

if ! command -v brew > /dev/null; then
    echo Installing homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo Updating and upgrading homebrew
brew update
brew upgrade

echo Installing dotfiles
install_dotfiles

echo Installing new software
source "$DOTFILES_ROOT/installers/pyenv.sh"

echo Restoring original working dir
popd > /dev/null

echo Bootstrap complete. You may reboot to verify everything is working as expected.
