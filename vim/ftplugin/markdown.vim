augroup MDXFileTypePlugins
  autocmd!
  " Format on save
  autocmd BufWritePre *.md,*.mdx lua vim.lsp.buf.formatting_sync()
augroup END
