# COLORS
PRIMARY='\033[1;33m' # YELLOW
SECONDARY='\033[0;36m' # CYAN
RESET='\033[0m' # No Color

if ! [[ -v NEOVIM_OS ]]; then
  echo "${PRIMARY}NEOVIM_OS${RESET} environment variable missing. Set it in ${SECONDARY}~/.zshrc_local_after${RESET}."
  echo "Possible options are: [${PRIMARY}Linux${RESET} | ${PRIMARY}macOS${RESET}]\n"
fi

if ! [[ -v TheSSH_ASDF_CONFIGURED ]]; then
  echo "${PRIMARY}asdf${RESET} is not configured. Configure it in ${SECONDARY}~/.zshrc_local_after${RESET} and set the ${PRIMARY}TheSSH_ASDF_CONFIGURED${RESET} environment variable to ${SECONDARY}true${RESET} once you're done.\n"
  echo "Potential ways to configure ${PRIMARY}asdf${RESET}:"
  echo "\t${PRIMARY}source${RESET} ${SECONDARY}/usr/local/opt/asdf/libexec/asdf.sh${RESET} (default)"
  echo "\t${PRIMARY}source${RESET} ${SECONDARY}\$(brew --prefix asdf)/libexec/asdf.sh${RESET} (macOS - homebrew)"
fi
