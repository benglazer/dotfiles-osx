#!/bin/bash

# Prefer homebrew to local executables.
if [ -d "/usr/local/bin" ]; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

# Set PATH to include user's private bin if it exists.
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Add primary ssh key to ssh-agent.
key_file=~/.ssh/id_rsa
[[ -z $(ssh-add -L | grep $key_file) ]] && ssh-add $key_file

### virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source `which virtualenvwrapper.sh`

### pip
export PIP_REQUIRE_VIRTUALENV=true  # pip runs only if a virtualenv is active
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache  # cache pip-installed packages
