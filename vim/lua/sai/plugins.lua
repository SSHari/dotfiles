local utils = require("utils")

local M = {}

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) == 0 then return false end

    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
               install_path})

    vim.cmd [[packadd packer.nvim]]

    return true
end

local packer_bootstrap = ensure_packer()

M.plugins = require("packer").startup(function(use)
    -- Packer manages itself
    use "wbthomason/packer.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use {"tzachar/cmp-tabnine", run = "./install.sh"}
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/vim-vsnip"

    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- Tree Sitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    -- Telescope
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"

    -- Language plugins
    use "elixir-editors/vim-elixir"
    use({"iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end})

    -- Workflow plugins
    use "ThePrimeagen/git-worktree.nvim"
    use "ThePrimeagen/harpoon"
    use "SSHari/jest.nvim"
    use "SSHari/vitest.nvim"
    use "tpope/vim-vinegar"
    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup {
                mapping = {"jk", "kj", "jj", "kk"},
                timeout = 200,
                clear_empty_lines = true
            }
        end
    }

    -- Visual
    use {"folke/tokyonight.nvim", branch = "main"}
    use "vim-airline/vim-airline"

    -- Other
    use "ThePrimeagen/vim-be-good"

    -----------------------
    -- Local Packer Plugins
    -----------------------
    utils.prequire({module = "sai.local", silent = true}).packer_startup(use)

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require("packer").sync() end
end)

-- Theme
vim.cmd("colorscheme tokyonight-night")

-- Configuration
utils.prequire({module = "git-worktree"}).setup {}
utils.prequire({module = "jest"}).setup {init_type = "autocmd"}
utils.prequire({module = "vitest"}).setup {init_type = "autocmd"}

require("sai.harpoon")
require("sai.telescope")
require("sai.treesitter")

return M
