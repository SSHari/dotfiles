augroup MDXFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.mdx lua vim.lsp.buf.formatting_sync()
augroup END
