#!/bin/bash

# Load aliases from .bash_aliases.
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# Enable bash completion.
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# Set up bash history.
shopt -s histappend  # append (vs overwrite) to history file
export HISTFILESIZE=1000000000  # 1 billion
export HISTSIZE=1000000  # 1 million

# Other Bash 4 options
shopt -s nocaseglob  # case-insensitive globbing (used in pathname expansion)
shopt -s cdspell  # autocorrect typos in path names when using `cd`
