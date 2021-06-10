"--------
" Plugins
"--------
call plug#begin('~/.vim/plugged')
if has('nvim')
  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'

  " Tree Sitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
endif

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'savq/melange'

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-vinegar'
Plug 'elixir-editors/vim-elixir'
call SourceLocalFile("~/.vim/config/plugin_list_local.vim")
call plug#end()

"--------------
" Configuration
"--------------
" theme
colorscheme melange

if has('nvim')
  " Telescope
  nnoremap <leader>b :Telescope buffers<CR>
  nnoremap <leader>l :Telescope current_buffer_fuzzy_find<CR>
  nnoremap <leader>P :Telescope find_files<CR>
  nnoremap <leader>p :Telescope git_files<CR>
  nnoremap <leader>H :Telescope help_tags<CR>
  nnoremap <leader>/ :Telescope live_grep<CR>
  nnoremap <leader>dot :lua require('_telescope').search_dotfiles()<CR>

  " lsp config
  set completeopt=menuone,noinsert,noselect
endif
