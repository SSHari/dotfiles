# Current Directory
plugin_dir=${0:a:h}

######################
# ZSH Auto Suggestions
######################
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source $plugin_dir/zsh-autosuggestions/zsh-autosuggestions.zsh

#########################
# ZSH Syntax Highlighting
#########################
source $plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###################
# ZSH Vim Mode
# (after highlight)
###################
# Use Control-D instead of Escape to switch to NORMAL mode
VIM_MODE_VICMD_KEY='^D'
source $plugin_dir/zsh-vim-mode/zsh-vim-mode.plugin.zsh

##############################
# ZSH History Substring Search
##############################
# Vim Commands
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
source $plugin_dir/zsh-history-substring-search/zsh-history-substring-search.zsh
