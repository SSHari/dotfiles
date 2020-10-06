"----------
" Functions
"----------
source ~/.vim/config/functions.vim

"-----------------
" General Settings
"-----------------
source ~/.vim/config/general.vim

"---------------
" Theme Settings
"---------------
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
