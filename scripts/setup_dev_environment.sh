#!/bin/bash

set -o nounset # error when referencing undefined variables
set -o errexit # exit when command fails

##### Install asdf
sudo apt install -y curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

##### Get asdf plugins
# Set up aws cli
sudo apt-get -y install curl tar unzip
asdf plugin-add awscli
asdf plugin-add aws-iam-authenticator https://github.com/stefansedich/asdf-aws-iam-authenticator
asdf plugin-add bat
# Set up erlang
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add fd
# Set up Go
sudo apt -y install coreutils
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add hub
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
# Set up lua
sudo apt-get -y install linux-headers-$(uname -r) build-essential
asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git
asdf plugin-add neovim
# Set up nodejs
sudo apt-get -y install dirmngr gpg curl gawk
asdf plugin-add nodejs 
# Set up postgres
sudo apt-get -y install libreadline-dev zlib1g-dev curl
asdf plugin-add postgres 
asdf plugin-add ripgrep 
# Install ruby
sudo apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

##### Install asdf plugins
cd ~
asdf install # Installs versions based on global .tool-versions file

##### Install Okteto Cli
curl https://get.okteto.com -sSfL | sh

##### Source zshrc file to make sure above tools are available
source ~/.zshrc

##### Setup language servers
go get github.com/mattn/efm-langserver
asdf reshim golang
npm install -g typescript-language-server vim-language-server
# Build lua language server and set up formatter
sudo apt-get -y install ninja
~/.dotfiles/scripts/setup_lua_language_server.sh
luarocks install --server=https://luarocks.org/dev luaformatter
# Build Elixir language server
~/.dotfiles/scripts/setup_elixir_language_server.sh

##### Set up htmlbeautifier for eelixir template formatting
gem install htmlbeautifier
