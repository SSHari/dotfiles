" Format on save
autocmd BufWritePre *.ts,*.tsx lua vim.lsp.buf.formatting_sync()
