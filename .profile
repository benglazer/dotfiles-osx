#!/bin/bash

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Vars for HISTORY
shopt -s histappend  # enable appends (rather than overwrites) to history file
export HISTFILESIZE=1000000000
export HISTSIZE=1000000

# Prefer homebrew to local executables.
if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Load aliases from .bash_aliases.
if [ -f "$HOME/.bash_aliases" ]
    . "$HOME/.bash_aliases"
fi

# Enable bash completion.
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Add primary ssh key to ssh-agent.
key_file=~/.ssh/id_rsa
[[ -z $(ssh-add -L | grep $key_file) ]] && ssh-add $key_file
