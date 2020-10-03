"-----------------
" General Settings
"-----------------
set autoindent
set expandtab
set nu
set shiftwidth=2
set smartindent
set tabstop=2
syntax on
colorscheme gruvbox

"------------------
" File Type Plugins
"------------------
autocmd BufNewFile,BufRead *.rs source ~/.vim/ftplugin/rust.vim

"--------------------
" Local Configuration
"--------------------
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
