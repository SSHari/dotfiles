"----------
" Functions
"----------
source ~/.vim/config/functions.vim

"-----------------
" General Settings
"-----------------
source ~/.vim/config/general.vim

"------------------
" File Type Plugins
"------------------
autocmd BufNewFile,BufRead *.rs source ~/.vim/ftplugin/rust.vim
autocmd BufNewFile,BufRead *.ex,*.exs source ~/.vim/ftplugin/elixir.vim

"---------
" Vim Plug
"---------
source ~/.vim/config/plugins.vim

"--------------------
" Local Configuration
"--------------------
call SourceLocalFile("~/.vimrc_local")
