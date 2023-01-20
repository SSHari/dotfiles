# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '<path>/.zshrc_local_before'
# End of lines added by compinstall

# Set up asdf completions
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Set up homebrew completions
if command -v brew &> /dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
