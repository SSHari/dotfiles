local utils = require("utils")

return utils.build_module_wrapper({
    build_keymaps = function(keymap_set)
        keymap_set("n", "<leader>a", function() utils.prequire("harpoon.mark").add_file() end,
                   {noremap = true, silent = true, desc = "Harpoon: set mark"})

        keymap_set("n", "<leader>hu", function() utils.prequire("harpoon.ui").toggle_quick_menu() end,
                   {noremap = true, silent = true, desc = "Harpoon: toggle quick menu"})

        keymap_set("n", "<leader>hn", function () utils.prequire("harpoon.ui").nav_next() end,
                   {noremap = true, silent = true, desc = "Harpoon: nav next"})

        keymap_set("n", "<leader>hp", function () utils.prequire("harpoon.ui").nav_prev() end,
                   {noremap = true, silent = true, desc = "Harpoon: nav prev"})
    end
})
