augroup GoFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.go,*.gomod,*.gotimpl lua vim.lsp.buf.formatting_sync()
augroup END
