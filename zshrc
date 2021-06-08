# Local Configuration (Before)
if [ -f ~/.zshrc_local_before ]; then
  source ~/.zshrc_local_before
fi

# Configure Settings
source ~/.zsh/settings.zsh

# Configure Completions
source ~/.zsh/completions.zsh

# Configure Prompt
source ~/.zsh/prompt.zsh

# General Configuration
source ~/.zsh/general.zsh

# Local Configuration (After)
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

alias luamake=/home/sai/.dotfiles/submodules/lua-language-server/3rd/luamake/luamake
