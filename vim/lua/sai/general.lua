local utils = require("sai.utils")

----------------
-- Base Settings
----------------
vim.o.background = "dark"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.undodir = utils.get_path_with_home(".vim/undodir")
vim.o.undofile = true

----------------
-- Fold Settings
----------------
vim.o.foldmethod = "indent"
vim.o.foldenable = false

------------------
-- Search Settings
------------------
vim.o.hlsearch = true
vim.o.incsearch = true

-----------------------
-- White Space Settings
-----------------------
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

---------------
-- Key Mappings
---------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

------------------------
-- General Auto Commands
------------------------
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("TheSSHGuy_Source_Config", {clear = true}),
    pattern = {utils.get_path_with_home(".dotfiles/vimrc"),
               utils.get_path_with_home(".dotfiles/vim/*")},
    callback = function()
        -- Source VimRC on updates
        vim.api.nvim_cmd({cmd = "source", args = {utils.get_path_with_home(".vimrc")}}, {})
    end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = vim.api.nvim_create_augroup("TheSSHGuy_Expand_Folds", {clear = true}),
    pattern = "*",
    callback = function()
        -- Expand all folds by default
        vim.cmd("normal zR")
    end
})

