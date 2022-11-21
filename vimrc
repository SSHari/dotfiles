"----------
" Functions
"----------
source ~/.vim/config/functions.vim

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
