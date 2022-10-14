# Local Configuration (Before)
if [ -f ~/.zshrc_local_before ]; then
  source ~/.zshrc_local_before
fi

# Configuration (Before)
source ~/.zsh/zshrc_before.zsh

# Configure Settings
source ~/.zsh/settings.zsh

# Configure Completions
source ~/.zsh/completions.zsh

# Configure Prompt
source ~/.zsh/prompt.zsh

# Configuration (After)
source ~/.zsh/zshrc_after.zsh

# Local Configuration (After)
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi

autoload -U +X bashcompinit && bashcompinit

# Configure Plugins
source ~/.zsh/plugins/init.zsh

