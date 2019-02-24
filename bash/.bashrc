#!/bin/bash

echo Running .bashrc

# Load aliases from .bash_aliases.
if [[ -f "${HOME}/.bash_aliases" ]]; then
    source "${HOME}/.bash_aliases"
fi

# Enable bash tab completion.
if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards.
[[ -e "${HOME}/.ssh/config" ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Bash 4 options.
shopt -s nocaseglob  # case-insensitive globbing (used in pathname expansion)
shopt -s cdspell  # autocorrect typos in path names when using `cd`

# Load extensions.
source "$HOME/.bashrc-extensions/history.sh"
