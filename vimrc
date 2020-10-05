"----------
" Functions
"----------
source ~/.vim/config/functions.vim

"-----------------
" General Settings
"-----------------
set autoindent
set expandtab
set number
set shiftwidth=2
set smartindent
set tabstop=2
syntax on
colorscheme gruvbox

"------------------
" File Type Plugins
"------------------
autocmd BufNewFile,BufRead *.rs source ~/.vim/ftplugin/rust.vim

"---------
" Vim Plug
"---------
call plug#begin('~/.vim/plugged')
source ~/.vim/config/plugin_list.vim
call SourceLocalFile("~/.vim/config/plugin_list_local.vim")
call plug#end()

"--------------------
" Local Configuration
"--------------------
call SourceLocalFile("~/.vimrc_local")
