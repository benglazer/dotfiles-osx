#!/bin/bash

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash  # via https://github.com/pyenv/pyenv-installer

source ../bash/.profile-extensions/pyenv.sh
pyenv install $(latest_python2_stable)
pyenv install $(latest_python3_stable)
