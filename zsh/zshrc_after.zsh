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

function zla() {
  vim ~/.zshrc_local_after
  source ~/.zshrc
}

# PATH Configuration
PATH="$HOME/.bin:$PATH"

# Set nvim as the default editor
export EDITOR='nvim'
export VISUAL='nvim'

# Set up kubectl
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef __start_kubectl k
fi

# Set up helm
if command -v helm &> /dev/null; then
  source <(helm completion zsh)
fi

# Add hub (git wrapper)
if command -v hub &> /dev/null; then
  eval "$(hub alias -s)"
fi

# Add direnv Configuration
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi
