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

    -- Config
    use "lewis6991/impatient.nvim"

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
    use {
        "nvim-telescope/telescope.nvim",
        keys = require("sai.telescope").packer_keymaps,
        config = function() require("sai.telescope").config() end
    }
    use {"nvim-telescope/telescope-fzy-native.nvim", module = "telescope"}

    -- Language plugins
    use {"elixir-editors/vim-elixir", ft = {"ex", "exs", "eex", "leex"}}
    use({"iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end})

    -- Workflow plugins
    use {"ThePrimeagen/git-worktree.nvim", config = function() require("git-worktree").setup {} end}
    use {
        "ThePrimeagen/harpoon",
        keys = require("sai.harpoon").packer_keymaps,
        config = function() require("sai.harpoon").config() end
    }
    use {"SSHari/jest.nvim", config = function() require("jest").setup {init_type = "autocmd"} end}
    use {
        "SSHari/vitest.nvim",
        config = function() require("vitest").setup {init_type = "autocmd"} end
    }
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
    use "kyazdani42/nvim-web-devicons"
    use {
        "nvim-lualine/lualine.nvim",
        config = function() require("lualine").setup() end,
        requires = "kyazdani42/nvim-web-devicons"
    }
    use "rcarriga/nvim-notify"

    -- Other
    use "ThePrimeagen/vim-be-good"

    -----------------------
    -- Local Packer Plugins
    -----------------------
    utils.prequire({"sai.local", silent = true}).packer_startup(use)

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require("packer").sync() end
end)

-- Theme
vim.cmd("colorscheme tokyonight-night")

require("sai.treesitter")

return M
