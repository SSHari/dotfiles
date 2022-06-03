set shiftwidth=4
set softtabstop=4
set tabstop=4

augroup LuaFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync()
augroup END
