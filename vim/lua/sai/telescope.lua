local utils = require("utils")

return utils.build_module_wrapper({
    config = function()
        local telescope = utils.prequire("telescope")
        local sorters = utils.prequire("telescope.sorters")
        local previewers = utils.prequire("telescope.previewers")

        telescope.setup {
            defaults = {
                file_sorter = sorters.get_fzy_sorter,
                prompt_prefix = " >",
                color_devicons = true,
                file_previewer = previewers.vim_buffer_cat.new,
                grep_previewer = previewers.vim_buffer_vimgrep.new,
                qflist_previewer = previewers.vim_buffer_qflist.new
            },
            extensions = {
                fzy_native = {override_generic_sorter = false, override_file_sorter = true}
            }
        }

        telescope.load_extension("fzy_native")
        telescope.load_extension("git_worktree")
    end,
    build_keymaps = function(keymap_set)
        keymap_set("n", "<leader>b", ":Telescope buffers<CR>", {noremap = true, silent = true})
        keymap_set("n", "<leader>l", ":Telescope current_buffer_fuzzy_find<CR>",
                   {noremap = true, silent = true})
        keymap_set("n", "<leader>P", ":Telescope find_files<CR>", {noremap = true, silent = true})
        keymap_set("n", "<leader>p", ":Telescope git_files<CR>", {noremap = true, silent = true})
        keymap_set("n", "<leader>H", ":Telescope help_tags<CR>", {noremap = true, silent = true})
        keymap_set("n", "<leader>/", ":Telescope live_grep<CR>", {noremap = true, silent = true})
        keymap_set("n", "<leader>gD", ":Telescope lsp_definitions<CR>",
                   {noremap = true, silent = true})
        keymap_set("n", "<leader>gR", ":Telescope lsp_references<CR>",
                   {noremap = true, silent = true})
        keymap_set("n", "<leader>dot", function()
            utils.prequire("telescope.builtin").git_files({
                prompt_title = "< Dotfiles >",
                cwd = "~/.dotfiles/"
            })
        end, {noremap = true, silent = true, desc = "search dotfiles"})

        -- Telescope (Git Worktrees)
        keymap_set("n", "<leader>gw", function()
            utils.prequire("telescope").extensions.git_worktree.git_worktrees()
        end, {noremap = true, silent = true, desc = "Git Worktree: list work trees"})

        keymap_set("n", "<leader>cgw", function()
            utils.prequire("telescope").extensions.git_worktree.create_git_worktree()
        end, {noremap = true, silent = true, desc = "Git Worktree: create work tree"})
    end
})

