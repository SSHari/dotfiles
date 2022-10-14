"----------
" Functions
"----------
source ~/.vim/config/functions.vim

"-----------------
" General Settings
"-----------------
source ~/.vim/config/general.vim

"---------
" Vim Plug
"---------
source ~/.vim/config/plugins.vim

"------------------
" Lua Configuration
"------------------
if has('nvim')
  lua require('init')
endif

"--------------------
" Local Configuration
"--------------------
call SourceLocalFile("~/.vimrc_local")
