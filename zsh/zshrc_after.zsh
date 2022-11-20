# Aliases
alias gdf='git diff $(git ls-files --modified | sed -n 1p)'
alias gaf='git add $(git ls-files --modified | sed -n 1p)'
alias vim='nvim'
alias dotfiles='cd ~/.dotfiles'
alias luamake='~/.config/nvim/lua-language-server/3rd/luamake/luamake'

# Install latest nightly neovim
alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'

# Functions
function global() {
  echo 'Looking up global npm packages...'
  npm list -g --depth=0
}

# PATH Configuration
PATH="$HOME/.bin:$PATH"

# Set nvim as the default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Set up kubectl
source <(kubectl completion zsh)
alias k=kubectl
compdef __start_kubectl k

# Set up helm
source <(helm completion zsh)

# Set Neovim OS for internal config (Linux or macOS)
# Set in zshrc_local_after
# export NEOVIM_OS='macOS'
