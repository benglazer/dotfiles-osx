#!/bin/bash

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Prefer homebrew to local executables
if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Java vars
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home

# bash built-ins
alias ls='ls -FG'
alias ll='ls -al'
alias lh='ls -lh'
alias l=ls
alias mv='mv -i'
alias mkdir='mkdir -p'
alias find='find .'
alias ..='cd ..'

# git
alias gpush='git push origin'
alias gpull='git pull origin'
alias gst='git st'
alias gdf='git df'
alias gl='git l'
alias ga='git add'
alias gap='git add -p'
alias gci='git commit -m'
alias gco='git checkout'
alias gbr='git branch'
alias gf='git fetch'
alias gm='git merge'

# homebrew
alias bi='brew info'
alias bui='brew uses --installed'
alias bu='brew uninstall'
alias bl='brew list'
alias bup='brew update'
alias bug='brew upgrade'

# django and south
alias da='./manage.py'
alias mmb='./manage.py migrate base'
alias msba='./manage.py schemamigration base --auto'

# misc utilities
alias webserver='python -m SimpleHTTPServer 8080'  # Serve files from cwd
# Show 30 most commonly used commands from history
alias hfreq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
# or pg_ctl -D /usr/local/var/postgres -l logfile start
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Vars for HISTORY
shopt -s histappend   # enable appends (rather than overwrites) to history file
export HISTFILESIZE=1000000000
export HISTSIZE=1000000

# Tab completion for SSH 'host' aliases
if [ -f /opt/local/etc/bash_completion ]; then
. /opt/local/etc/bash_completion
fi 

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source `which virtualenvwrapper.sh`
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages' # put everything in the virtualenv, even if it duplicates system site-packages
