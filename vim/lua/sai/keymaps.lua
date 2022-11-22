local utils = require('utils')

vim.keymap.set("n", "<leader><leader>x", utils.write_and_source,
               {noremap = true, silent = true, desc = "Write file and source it"})
