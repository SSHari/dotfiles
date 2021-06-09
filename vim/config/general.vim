"--------------
" Base Settings
"--------------
set background=dark
set number
set relativenumber
set ruler
set splitbelow
set splitright
set termguicolors
set undodir=~/.vim/undodir
set undofile
syntax on

"--------------
" Fold Settings
"--------------
set foldmethod=indent
set nofoldenable
" Expand all folds by default
autocmd BufNewFile,BufRead * normal zR

"----------------
" Search Settings
"----------------
set hlsearch
set incsearch

"---------------------
" White Space Settings
"---------------------
set autoindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

"-------------
" Key Mappings
"-------------
let mapleader="\<Space>"

"-------------
" Source VimRC
"-------------
autocmd BufWritePost ~/.dotfiles/vimrc,~/.dotfiles/vim/* source ~/.vimrc
