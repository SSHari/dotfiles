"--------
" Plugins
"--------
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

"--------------
" Configuration
"--------------
" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
