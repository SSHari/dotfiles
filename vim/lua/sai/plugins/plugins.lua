return {
  { "nvim-tree/nvim-web-devicons" },
  { "tpope/vim-vinegar" },
  {
    "max397574/better-escape.nvim",
    opts = {},
  },
  {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = { view_options = { show_hidden = true } },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      lazy = false,
  }
}
