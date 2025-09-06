local utils = require("sai.utils")

vim.keymap.set("n", "<leader><leader>x", utils.write_and_source,
               {noremap = true, silent = true, desc = "Write file and source it"})

-- Yank to clipboard
vim.keymap.set("x", "<leader>y", "\"+y",
               {noremap = true, silent = true, desc = "Copy visual selection to clipboard"})

vim.keymap.set("n", "<leader>yy", "\"+yy",
               {noremap = true, silent = true, desc = "Copy line to clipboard"})
