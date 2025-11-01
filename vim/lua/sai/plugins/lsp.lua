local utils = require("sai.utils")

-- Set up on base attach function
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Builds an lsp buffer command
    local function buf_cmd(command) return "<cmd>lua vim.lsp.buf." .. command .. "()<CR>" end

    -- Builds an lsp diagnostic command
    local function diagnostic_cmd(command)
        return "<cmd>lua vim.diagnostic." .. command .. "()<CR>"
    end

    -- Mappings
    local opts = {noremap = true, silent = true}

    buf_set_keymap("n", "<leader>gd", buf_cmd("definition"), opts)
    buf_set_keymap("n", "<leader>gr", buf_cmd("references"), opts)
    buf_set_keymap("n", "<leader>i", buf_cmd("hover"), opts)
    buf_set_keymap("n", "<leader>d", diagnostic_cmd("open_float"), opts)
    buf_set_keymap("n", "<leader>dp", diagnostic_cmd("goto_prev"), opts)
    buf_set_keymap("n", "<leader>dn", diagnostic_cmd("goto_next"), opts)

    -- Enable manual completion via <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local efm_languages = {
  eelixir = {{formatCommand = utils.get_path_with_home(".asdf/installs/ruby/3.0.1/bin/htmlbeautifier"), formatStdin = true}},
  lua = {{formatCommand = "lua-format", formatStdin = true}},
  javascript = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  javascriptreact = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  typescript = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  typescriptreact = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  markdown = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  mdx = {{formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}},
  rust = {{formatCommand = "rustfmt", formatStdin = true}},
  prisma = {{formatCommand = "./node_modules/.bin/prisma format --stdin-filepath ${INPUT}", formatStdin = true}}
}

-- Server configurations mapping
local server_configs = {
  -- Simple servers that just need basic setup
  bashls = { cmd = { "bash-language-server", "start" } },
  cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
  jedi_language_server = { cmd = { "jedi-language-server" } },
  rust_analyzer = { cmd = { "rust-analyzer" } },
  tailwindcss = { cmd = { "tailwindcss-language-server", "--stdio" } },
  yamlls = { cmd = { "yaml-language-server", "--stdio" } },
  vimls = { cmd = { "vim-language-server", "--stdio" } },
  -- Servers with custom on_attach functions
  elixirls = {
    cmd = { "elixir-ls" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = vim.bo.filetype ~= "eelixir"
      on_attach(client, bufnr)
    end,
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    settings = {
      Lua = {
        runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
        diagnostics = {globals = {"vim", "P"}},
        workspace = {library = vim.api.nvim_get_runtime_file("", true), ignoreDir = {"undodir"}},
        telemetry = {enable = false}
      }
    },
  },
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    handlers = {
      ["textDocument/publishDiagnostics"] = function(err, result, ctx)
        if (result) then
          local diagnostics = {}
          local codes_to_ignore = {7016, 80001}
          for _, diagnostic in ipairs(result.diagnostics) do
            if (not utils.list_includes(codes_to_ignore, diagnostic.code)) then
              table.insert(diagnostics, diagnostic)
            end
          end
          result.diagnostics = diagnostics
        end
        return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
      end
    },
  },
  gopls = {
    cmd = { "gopls" },
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
  },
  -- Special case for EFM
  efm = {
    cmd = { "efm-langserver" },
    on_init = function()
      local pattern = {"*.js", "*.jsx", "*.ts", "*.tsx", "*.lua", "*.ex", "*.exs",
                       "*.eex", "*.leex", "*.go", "*.gomod", "*.gotimpl", "*.md", "*.mdx",
                       "*.rs", "*.prisma"}
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("TheSSHGuy_EFM_Formatter", {clear = true}),
        pattern = pattern,
        callback = function() vim.lsp.buf.format({timeout_ms = 2000}) end
      })
    end,
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(efm_languages),
    settings = {rootMarkers = {".git/", "package.json"}, languages = efm_languages},
  }
}

return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-y>'] = { 'accept', 'fallback' },
      },
      completion = {
        list = {
          selection = { preselect = true, auto_insert = true },
        },
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = utils.prequire('blink.cmp').get_lsp_capabilities()
      -- Configure each LSP server using vim.lsp.config
      for server_name, config in pairs(server_configs) do
        -- Set default on_attach if not specified
        if not config.on_attach then
          config.on_attach = on_attach
        end
        -- Set capabilities
        config.capabilities = capabilities
        -- Configure the server
        vim.lsp.config[server_name] = config
      end
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {"bashls", "cssls", "efm", "elixirls", "gopls", "jedi_language_server",
                          "rust_analyzer", "lua_ls", "tailwindcss", "ts_ls", "yamlls", "vimls"},
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    }
  }
}
