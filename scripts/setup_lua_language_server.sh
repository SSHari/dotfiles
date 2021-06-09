#!/bin/bash

set -o nounset # error when referencing undefined variables
set -o errexit # exit when command fails

# Exit if ninja does not exist
if [ ! -x "$(command -v ninja)" ]; then
  echo "Could not find an instance of ninja on this machine. Install ninja and try again."
  exit
fi

# Navigate to Lua Language Server
cd ~/.config/nvim/lua-language-server

# Install Lua Language Server
git submodule update --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
