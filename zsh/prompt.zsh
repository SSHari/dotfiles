# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt
setopt PROMPT_SUBST
PROMPT='%F{31}%~%F{green} ${vcs_info_msg_0_} %F{124}(ಠ_ಠ)%f$ '
