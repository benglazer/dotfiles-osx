#!/bin/bash

# Load the shell dotfiles.
for file in ~/.{profile,bashrc}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

export PATH="/usr/local/foreman/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
