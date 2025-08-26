-- Local Variables and Functions
local utils = require("utils")
local cmp = utils.prequire("cmp")
local tabnine = utils.prequire("cmp_tabnine.config")

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

-- Set up nvim-cmp
cmp.setup({
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "nvim_lua"}, {name = "cmp_tabnine"},
                                  {name = "path"}, {name = "buffer"}})
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "cmdline"}, {name = "buffer"}})
})

tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    show_prediction_strength = true
})

-- Capabilities
local capabilities = utils.prequire("cmp_nvim_lsp").default_capabilities()

-- LSP Setup
local lspconfig = utils.prequire("lspconfig")
local mason_registry = utils.prequire("mason-registry")
local mason_lspconfig = utils.prequire("mason-lspconfig")

utils.prequire("mason").setup()
mason_lspconfig.setup {
    ensure_installed = {"bashls", "cssls", "efm", "elixirls", "gopls", "jedi_language_server",
                        "rust_analyzer", "lua_ls", "tailwindcss", "ts_ls", "yamlls", "vimls"},
    automatic_installation = true
}

local mappings = mason_lspconfig.get_mappings().lspconfig_to_mason
mason_lspconfig.setup_handlers {
    function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end
        lspconfig[server_name].setup {on_attach = on_attach, capabilities = capabilities}
    end,
    ["efm"] = function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end

        local prettier = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}"
        local html_beautifier = utils.get_path_with_home(
                                    ".asdf/installs/ruby/3.0.1/bin/htmlbeautifier")
        local prismafmt = "./node_modules/.bin/prisma format --stdin-filepath ${INPUT}"

        local efm_languages = {
            eelixir = {{formatCommand = html_beautifier, formatStdin = true}},
            lua = {{formatCommand = "lua-format", formatStdin = true}},
            javascript = {{formatCommand = prettier, formatStdin = true}},
            javascriptreact = {{formatCommand = prettier, formatStdin = true}},
            typescript = {{formatCommand = prettier, formatStdin = true}},
            typescriptreact = {{formatCommand = prettier, formatStdin = true}},
            markdown = {{formatCommand = prettier, formatStdin = true}},
            mdx = {{formatCommand = prettier, formatStdin = true}},
            rust = {{formatCommand = "rustfmt", formatStdin = true}},
            prisma = {{formatCommand = prismafmt, formatStdin = true}}
        }

        lspconfig[server_name].setup {
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
            capabilities = capabilities
        }
    end,
    ["elixirls"] = function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end

        lspconfig[server_name].setup {
            on_attach = function(client, bufnr)
                -- Disable formatting for Elixir Templates (eelixir) in favor of htmlbeautifier
                client.server_capabilities.documentFormattingProvider = vim.bo.filetype ~= "eelixir"
                on_attach(client, bufnr)
            end,
            capabilities = capabilities
        }
    end,
    ["gopls"] = function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end

        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
        }
    end,
    ["lua_ls"] = function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end

        local get_lua_lsp_library_files = function()
            local runtime_files = vim.api.nvim_get_runtime_file("", true)
            table.insert(runtime_files, vim.fn.expand("$VIMRUNTIME/lua"))
        end

        lspconfig[server_name].setup {
            on_attach = function(client, bufnr)
                -- Disable EmmyLuaCodeStyle formatting in favor of LuaFormatter
                client.server_capabilities.documentFormattingProvider = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
                    diagnostics = {globals = {"vim", "P"}},
                    workspace = {library = get_lua_lsp_library_files(), ignoreDir = {"undodir"}},
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {enable = false}
                }
            }
        }
    end,
    ["ts_ls"] = function(server_name)
        if (not mason_registry.is_installed(mappings[server_name])) then return end

        lspconfig[server_name].setup {
            on_attach = function(client, bufnr)
                -- Disable typescript formatting in favor of prettier
                client.server_capabilities.documentFormattingProvider = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            handlers = {
                ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                    if (result) then
                        -- Filter out diagnostics that we don't care about
                        -- Diagnostic codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                        local diagnostics = {}
                        local codes_to_ignore = {7016, 80001}
                        for _, diagnostic in ipairs(result.diagnostics) do
                            if (not utils.list_includes(codes_to_ignore, diagnostic.code)) then
                                table.insert(diagnostics, diagnostic)
                            end
                        end
                        result.diagnostics = diagnostics
                    end
                    return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
                end
            }
        }
    end
}
