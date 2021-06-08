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

# Local Configuration (After)
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi
