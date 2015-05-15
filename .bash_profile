#!/bin/bash

# Load the shell dotfiles.
for file in ~/.{profile,bashrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
