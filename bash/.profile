#!/bin/bash

echo Running .profile

# Prefer homebrew to local executables.
if [[ -d "/usr/local/bin" ]]; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

# Set PATH to include user's private bins if they exist.
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
fi

# Load extensions.
source "$HOME/.profile-extensions/ssh-agent.sh"
source "$HOME/.profile-extensions/pyenv.sh"
source "$HOME/.profile-extensions/nvm.sh"
