#!/bin/bash

set -o nounset # error when referencing undefined variables
set -o errexit # exit when command fails

# Exit if mix does not exist
if [ ! -x "$(command -v mix)" ]; then
  echo "Could not find an instance of mix on this machine. Install Elixir and try again."
  exit
fi

# Navigate to Elixir Language Server
cd ~/.config/nvim/elixir-language-server

# Install Elixir Language Server (https://github.com/elixir-lsp/elixir-ls#building-and-running)
git submodule update --init --recursive
mix deps.get
mix compile
mix elixir_ls.release -o language_server
