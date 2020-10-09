"--------
" Plugins
"--------
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/diagnostic-nvim'
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
  set completeopt=menuone,noinsert,noselect

  nnoremap <leader>d <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>

" This needs to start at the beginning of the line (i.e. No TAB)
lua << EOF
  local on_attach_vim = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
  end
  require'nvim_lsp'.tsserver.setup{on_attach=on_attach_vim}
EOF
endif
