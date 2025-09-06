local utils = require("sai.utils")

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>b", ":lua FzfLua.buffers()<CR>", "n"},
      { "<leader>P", ":lua FzfLua.files()<CR>", "n"},
      { "<leader>p", ":lua FzfLua.git_files()<CR>", "n"},
      { "<leader>H", ":lua FzfLua.helptags()<CR>", "n"},
      { "<leader>/", ":lua FzfLua.live_grep()<CR>", "n"},
      { "<leader>gD", ":lua FzfLua.lsp_definitions()<CR>", "n"},
      { "<leader>gR", ":lua FzfLua.lsp_references()<CR>", "n"},
      {
        "<leader>dot",
        function()
          utils.prequire("fzf-lua").git_files({
            cwd = "~/.dotfiles/"
          })
        end,
        "n"
      },
    }
  }
}
