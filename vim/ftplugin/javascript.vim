augroup JSFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.formatting_sync()
augroup END
