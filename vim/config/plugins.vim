"--------
" Plugins
"--------
call plug#begin('~/.vim/plugged')
if has('nvim')
  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Tree Sitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " Language plugins
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  " Workflow plugins
  Plug 'ThePrimeagen/git-worktree.nvim'
  Plug 'ThePrimeagen/harpoon'
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

  " Git Worktrees
  nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
  nnoremap <leader>cgw :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

  " Harpoon
  nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
  nnoremap <leader>hu :lua require("harpoon.ui").toggle_quick_menu()<CR>
  nnoremap <leader>hn :lua require("harpoon.ui").nav_next()<CR>
  nnoremap <leader>hp :lua require("harpoon.ui").nav_prev()<CR>

  " Utils
  nnoremap <leader><leader>x :lua require("utils").write_and_source()<CR>

  " lsp config
  set completeopt=menuone,noinsert,noselect

  call SourceLocalFile("~/.vim/config/plugin_remaps_local.vim")
endif
