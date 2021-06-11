# Aliases
alias gdf='git diff $(git ls-files --modified | sed -n 1p)'
alias gaf='git add $(git ls-files --modified | sed -n 1p)'
alias vim='nvim'
alias dotfiles='cd ~/.dotfiles'
alias luamake='~/.config/nvim/lua-language-server/3rd/luamake/luamake'

# Install latest nightly neovim
alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'

# Functions
function global() {
  echo 'Looking up global npm packages...'
  npm list -g --depth=0
}

# PATH Configuration
PATH="$HOME/.bin:$PATH"

# Setup asdf
source $HOME/.asdf/asdf.sh

# Set nvim as the default editor
export EDITOR='nvim'
export VISUAL='nvim'
