#!/bin/bash

# basics
alias ls='ls -FG'
alias ll='ls -la'
alias l=ls
alias mv='mv -i'
alias mkdir='mkdir -p'
alias find='find .'
alias ..='cd ..'

# fancy basics
alias hfreq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'  # show 30 most commonly used commands from history
alias webserver='python -m SimpleHTTPServer 8080'

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

# django manage.py for eduvant apps
alias mmb='./manage.py migrate base'
alias msba='./manage.py schemamigration base --auto'
alias mta='./manage.py test api'

# postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias dumpdb='pg_dump -Fc --no-owner eduvant-dev -f'  # then provide a dumpfile name
alias loaddb='pg_restore -d eduvant-dev -O -x -Fc '  # then provide an input file name
alias resetdb='dropdb eduvant-dev && createdb eduvant-dev && loaddb'

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source `which virtualenvwrapper.sh`
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'  # put everything in the virtualenv, even if it duplicates system site-packages

# django project
alias da='./manage.py'

# csv
alias csv='column -s, -t' # pipe in csv data to pretty-print
alias fixquotes="sed 's/\(.[^,\"]\)\"\([^,\"].\)/\1\"\"\2/g'"