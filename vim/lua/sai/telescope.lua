local utils = require("utils")

local telescope = utils.prequire("telescope")
local sorters = utils.prequire("telescope.sorters")
local previewers = utils.prequire("telescope.previewers")
local builtin = utils.prequire("telescope.builtin")

telescope.setup {
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new
    },
    extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
}

telescope.load_extension("fzy_native")
telescope.load_extension("git_worktree")

local search_dotfiles = function()
    builtin.git_files({prompt_title = "< Dotfiles >", cwd = "~/.dotfiles/"})
end

-----------
-- Key Maps
-----------
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>l", ":Telescope current_buffer_fuzzy_find<CR>",
               {noremap = true, silent = true})
vim.keymap.set("n", "<leader>P", ":Telescope find_files<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>p", ":Telescope git_files<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>H", ":Telescope help_tags<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>dot", search_dotfiles,
               {noremap = true, silent = true, desc = "search dotfiles"})

-- Telescope (Git Worktrees)
vim.keymap.set("n", "<leader>gw", utils.prequire("telescope").extensions.git_worktree.git_worktrees,
               {noremap = true, silent = true, desc = "Git Worktree: list work trees"})

vim.keymap.set("n", "<leader>cgw",
               utils.prequire("telescope").extensions.git_worktree.create_git_worktree,
               {noremap = true, silent = true, desc = "Git Worktree: create work tree"})
