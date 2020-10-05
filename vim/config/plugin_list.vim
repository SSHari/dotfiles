"--------
" Plugins
"--------
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

"--------------
" Configuration
"--------------
" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
