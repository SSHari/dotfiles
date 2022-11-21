local M = {}

-- Basic Plugins
require('git-worktree').setup({})
require('jest').setup({init_type = 'autocmd'})
require('vitest').setup({init_type = 'autocmd'})

-- Telescope
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
telescope.setup({
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new
    },
    extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
})

telescope.load_extension('fzy_native')
telescope.load_extension('git_worktree')

M.telescope = {
    search_dotfiles = function()
        builtin.git_files({prompt_title = '< Dotfiles >', cwd = '~/.dotfiles/'})
    end
}

-- Tree Sitter
require('nvim-treesitter.configs').setup({
    ensure_installed = "all",
    highlight = {enable = true},
    indent = {enable = true}
})

return M
