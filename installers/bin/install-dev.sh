#!/bin/bash

# Create the main dev dir.
mkdir ~/dev


### Install python.

echo "installing python..."

brew install python

# pip
mkdir $HOME/.pip/cache
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# virtualenvwrapper
pip install virtualenvwrapper
mkdir $HOME/.virtualenvs
export WORKON_HOME=$HOME/.virtualenvs

# pycharm
brew cask install caskroom/homebrew-versions/java6  # required by PyCharm
brew cask install --appdir="/Applications" Caskroom/cask/pycharm-ce


### postgres

echo "installing postgres..."

brew install postgres


### dotfiles

# First, clone the dotfiles repo into ~/dev.
cd ~/dev
git clone git://github.com/benglazer/dotfiles-osx

# Link files into home dir.
cd ~
ln -s dev/dotfiles-osx dotfiles
for file in dotfiles/.{profile,bash_profile,bashrc,bash_aliases,gitconfig,gitignore,vimrc}; do
	ln -s "$file"
done
unset file


### heroku

brew cask install heroku-toolbelt


### ssh

echo "Please copy over your ~/.ssh from a backup!"


### docker

brew cask install virtualbox
brew cask install docker
brew cask install boot2docker
brew cask install docker-compose
brew cask install docker-machine


### sublime text 3

echo "configuring sublime text 3"

# ensure ST3 is installed
brew cask install --appdir="/Applications" sublime-text3

# install Package Control
curl -o "$HOME/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package" https://packagecontrol.io/Package%20Control.sublime-package


