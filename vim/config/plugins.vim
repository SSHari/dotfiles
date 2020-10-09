"--------
" Plugins
"--------
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
endif
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
call SourceLocalFile("~/.vim/config/plugin_list_local.vim")
call plug#end()

"--------------
" Configuration
"--------------
" theme
colorscheme gruvbox

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" lsp config
if has('nvim')
  lua require'nvim_lsp'.tsserver.setup{ }

  set completeopt=menuone,noinsert,noselect
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
  lua require'nvim_lsp'.tsserver.setup{on_attach=require'completion'.on_attach}
endif
