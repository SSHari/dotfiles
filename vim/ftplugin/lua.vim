augroup LuaFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
augroup END
