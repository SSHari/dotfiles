"--------
" Plugins
"--------
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'savq/melange'
Plug 'tpope/vim-vinegar'
Plug 'elixir-editors/vim-elixir'
call SourceLocalFile("~/.vim/config/plugin_list_local.vim")
call plug#end()

"--------------
" Configuration
"--------------
" fzf
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>P :Files<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>H :Helptags!<CR>
nnoremap <leader>/ :Rg<CR>

" theme
colorscheme melange

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" lsp config
if has('nvim')
  set completeopt=menuone,noinsert,noselect

  nnoremap <leader>g <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <leader>i <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
  nnoremap <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

  :luafile ~/.vim/config/plugins.lua
endif
