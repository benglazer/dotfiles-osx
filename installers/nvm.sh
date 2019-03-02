#!/bin/bash

#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash  # via https://github.com/creationix/nvm

brew install nvm  # not officially supported but avoids .profile mangling
mkdir "${HOME}/.nvm"

source ../bash/.profile-extensions/nvm.sh
nvm install --lts
nvm use node

npm config delete prefix
npm config set prefix $NVM_DIR/versions/node/$(nvm version)
