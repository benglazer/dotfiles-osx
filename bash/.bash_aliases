#!/bin/bash

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias d="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dev="cd ~/dev"
alias g="git"
alias h="history"
alias j="jobs"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls="ls -F ${colorflag}"
alias l=ls
alias ll="ls -la"
# List directories only
alias lsd="ls -lF | grep --color=never '^d'"

# # Enable aliases to be sudo’ed
# alias sudo='sudo '

# basics
alias mv='mv -i'
alias mkdir='mkdir -p'
alias find='find .'

# Update OS X Software, Ruby gems, and Homebrew kegs
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; sudo gem update --system; sudo gem update'  # npm install npm -g; npm update -g;

# fancy one-liners
alias webserver='python -m SimpleHTTPServer 8080'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'  # stopwatch
alias hfreq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'  # show 30 most commonly used commands from history

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
	cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

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
alias gcomb='gco master -b'
alias gdf='git df'
alias gdfs='gdf --staged'
alias gf='git fetch --prune'
alias gm='git merge'
alias gg='git grep'
alias gss='git stash save'
alias gsp='git stash pop'

# homebrew
alias bi='brew info'
alias bui='brew uses --installed'
alias bun='brew uninstall'
alias bl='brew list'
alias bu='brew update'
alias bup='brew upgrade'

# postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias dumpdb='pg_dump -Fc --no-owner eduvant-dev -f'  # then provide a dumpfile name
alias loaddb='pg_restore -d eduvant-dev -O -x -Fc '  # then provide an input file name
alias resetdb='dropdb eduvant-dev && createdb eduvant-dev && loaddb'

# django
alias da='./manage.py'

# heroku
alias sfkey='heroku config:get SFUSD_OVERRIDE_PASSWORD -a edvnt-api | pbcopy'

# sync3
alias basis-extract='workon sync3_extract && PYTHONPATH=. foreman run sync3_extract/bin/sync3_extract'
alias basis-transform='workon sync3_transform && foreman run sync3_transform/bin/sync3_transform'
alias basis-load='workon api && foreman run ./manage.py loadcsv --archive'

# stellar
alias stellar-delete-all='for snapshot in $(stellar list | sed '\''s/: .*ago//'\''); do stellar remove $snapshot; done'
