#!/bin/bash

set -o nounset # error when referencing undefined variables
set -o errexit # exit when command fails

# Exit if node does not exist
if [ ! -x "$(command -v node)" ]; then
  echo "Could not find an instance of node on this machine. Install node and try again."
  exit
fi

# Navigate to coc symlink
cd ~/.vim/config/coc/extensions

# Install packages
npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
