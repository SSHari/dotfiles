local utils = require("utils")

vim.keymap.set("n", "<leader>a", utils.prequire({module = "harpoon.mark"}).add_file,
               {noremap = true, silent = true, desc = "Harpoon: set mark"})

vim.keymap.set("n", "<leader>hu", utils.prequire({module = "harpoon.ui"}).toggle_quick_menu,
               {noremap = true, silent = true, desc = "Harpoon: toggle quick menu"})

vim.keymap.set("n", "<leader>hn", utils.prequire({module = "harpoon.ui"}).nav_next,
               {noremap = true, silent = true, desc = "Harpoon: nav next"})

vim.keymap.set("n", "<leader>hp", utils.prequire({module = "harpoon.ui"}).nav_prev,
               {noremap = true, silent = true, desc = "Harpoon: nav prev"})
