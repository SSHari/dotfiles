augroup JSFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.ts,*.tsx lua vim.lsp.buf.formatting_sync()
augroup END
