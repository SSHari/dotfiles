-- Order matters
-- 1. globals
-- 2. general
-- 3. plugins
-- 4. lsp
require('globals')
require('general')
vim.api.nvim_cmd({
    cmd = "source",
    args = { require('utils').get_path_with_home(".vim/config/plugins.vim") }
}, {})
require('plugins')
require('lsp')
