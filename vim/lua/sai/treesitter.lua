local utils = require("utils")

utils.prequire("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {enable = true},
    indent = {enable = true}
}
