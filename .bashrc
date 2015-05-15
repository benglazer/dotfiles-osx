#!/bin/bash

# Load aliases from .bash_aliases.
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# Enable bash tab completion.
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Set up bash history.
shopt -s histappend  # append (vs overwrite) to history file
export HISTFILESIZE=1000000000  # 1 billion
export HISTSIZE=1000000  # 1 million

# Other Bash 4 options
shopt -s nocaseglob  # case-insensitive globbing (used in pathname expansion)
shopt -s cdspell  # autocorrect typos in path names when using `cd`

