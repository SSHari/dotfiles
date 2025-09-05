# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Installation

This dotfiles repository uses **dotbot** for automated installation and management of configuration files.

### Initial Setup
- Run `./install` to set up all dotfiles configurations
- The setup script uses `install.conf.yaml` to create symbolic links to configuration files

### Development Environment Setup
- Run `scripts/setup_dev_environment.sh` to install development tools and language servers
- This sets up asdf version manager, programming languages (Node.js, Go, Lua, Ruby, etc.), and development tools

## Architecture Overview

This is a personal dotfiles repository with the following main components:

### Core Structure
- **vim/**: Vim configuration files and Lua-based Neovim setup
- **config/nvim/**: Neovim configuration with lazy.nvim plugin manager
- **zsh/**: Zsh shell configuration with plugins and completions
- **tmux/**: Terminal multiplexer configuration
- **scripts/**: Setup and utility scripts for development environment

### Key Configuration Files
- `install.conf.yaml`: Dotbot configuration defining file linking
- `tool-versions`: asdf version manager configuration for development tools
- `zshrc`: Main Zsh configuration that sources modular configuration files
- `vim/lua/init.lua`: Main Neovim entry point

## Neovim Configuration

The Neovim setup uses a modern Lua-based configuration:

### Plugin Management
- Uses **lazy.nvim** as the plugin manager
- Plugin specifications are in `vim/lua/sai/plugins/`
- Automatically bootstraps lazy.nvim on first run

### Configuration Structure
- `vim/lua/general.lua`: Base Neovim settings (numbers, search, indentation)
- `vim/lua/sai/keymaps.lua`: Custom key mappings
- `vim/lua/sai/config/lazy.lua`: Plugin manager bootstrap and setup
- `vim/lua/sai/plugins/`: Individual plugin configurations

### Language Servers
Language servers are installed via setup scripts:
- Lua: Built from source in `config/nvim/lua-language-server/`
- Elixir: Built from source in `config/nvim/elixir-language-server/`
- TypeScript, Vim: Installed via npm
- EFM Language Server: Installed via Go

## Version Management

Uses **asdf** for managing development tool versions:
- Tool versions are specified in `tool-versions` file
- Includes Node.js, Go, Python, Rust, Terraform, and other development tools
- Use `asdf install` to install all specified versions

## Shell Configuration

Zsh configuration is modular:
- Main config in `zshrc` sources files from `~/.zsh/`
- Includes plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-vim-mode
- Plugin management in `zsh/plugins/init.zsh`

## Git Configuration

- Uses git submodules for external dependencies (dotbot, zsh plugins, language servers)
- Run `git submodule update --init --recursive` to initialize all submodules

## Important Development Commands

### Environment Setup
```bash
# Install all dotfiles
./install

# Set up development environment (Linux-specific)
scripts/setup_dev_environment.sh

# Install asdf tool versions
asdf install

# Update git submodules
git submodule update --init --recursive
```

### Language Server Setup
```bash
# Build Lua Language Server
scripts/setup_lua_language_server.sh

# Build Elixir Language Server
scripts/setup_elixir_language_server.sh
```

### Neovim
- Plugin management is automatic via lazy.nvim
- Leader key is space bar
- Local leader key is backslash