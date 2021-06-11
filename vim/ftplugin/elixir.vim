augroup ElixirFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.ex,*.exs,*.eex,*.leex lua vim.lsp.buf.formatting_sync()
augroup END
