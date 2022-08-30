-- Local Variables and Functions
local cmp = require('cmp')
local lspconfig = require('lspconfig')
local utils = require('utils')

-- Set up on base attach function
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Builds an lsp buffer command
    local function buf_cmd(command)
        return '<cmd>lua vim.lsp.buf.' .. command .. '()<CR>'
    end

    -- Builds an lsp diagnostic command
    local function diagnostic_cmd(command)
        return '<cmd>lua vim.diagnostic.' .. command .. '()<CR>'
    end

    -- Mappings
    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', '<leader>g', buf_cmd('definition'), opts)
    buf_set_keymap('n', '<leader>i', buf_cmd('hover'), opts)
    buf_set_keymap('n', '<leader>d', diagnostic_cmd("open_float"), opts)
    buf_set_keymap('n', '<leader>dp', diagnostic_cmd('goto_prev'), opts)
    buf_set_keymap('n', '<leader>dn', diagnostic_cmd('goto_next'), opts)

    -- Enable manual completion via <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Set up nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}}, {{name = 'buffer'}})
})

-- Capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol
                                                                     .make_client_capabilities())

-- Elixir LSP
lspconfig.elixirls.setup {
    cmd = {utils.get_path_with_home(
        ".config/nvim/elixir-language-server/language_server/language_server.sh")},
    on_attach = function(client, bufnr)
        -- Disable formatting for Elixir Templates (eelixir) in favor of htmlbeautifier
        client.server_capabilities.documentFormattingProvider = vim.bo.filetype ~= 'eelixir'
        on_attach(client, bufnr)
    end,
    capabilities = capabilities
}

-- TypeScript LSP
lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        -- Disable typescript formatting in favor of prettier
        client.server_capabilities.documentFormattingProvider = false

        on_attach(client, bufnr)
    end,
    capabilities = capabilities
}

-- Lua LSP
local sumneko_root_path = utils.get_path_with_home(".config/nvim/lua-language-server")
local sumneko_os_path = utils.get_by_os("Linux", "macOS")
local sumneko_binary = sumneko_root_path .. "/bin/" .. sumneko_os_path .. "/lua-language-server"
local get_lua_lsp_library_files = function()
    local runtime_files = vim.api.nvim_get_runtime_file("", true)
    table.insert(runtime_files, vim.fn.expand("$VIMRUNTIME/lua"))
end
lspconfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim', 'P'}},
            workspace = {library = get_lua_lsp_library_files(), ignoreDir = {"undodir"}},
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

-- EFM LSP
local prettier = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}"
local html_beautifier = utils.get_path_with_home(".asdf/installs/ruby/3.0.1/bin/htmlbeautifier")

local efm_languages = {
    eelixir = {{formatCommand = html_beautifier, formatStdin = true}},
    lua = {{formatCommand = "lua-format", formatStdin = true}},
    javascript = {{formatCommand = prettier, formatStdin = true}},
    javascriptreact = {{formatCommand = prettier, formatStdin = true}},
    typescript = {{formatCommand = prettier, formatStdin = true}},
    typescriptreact = {{formatCommand = prettier, formatStdin = true}},
    markdown = {{formatCommand = prettier, formatStdin = true}},
    mdx = {{formatCommand = prettier, formatStdin = true}}
}

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(efm_languages),
    settings = {rootMarkers = {".git/", "package.json"}, languages = efm_languages},
    capabilities = capabilities
}

-- Vim LSP
lspconfig.vimls.setup {on_attach = on_attach, capabilities = capabilities}

-- Bash LSP
lspconfig.bashls.setup {on_attach = on_attach, capabilities = capabilities}

-- Python LSP
lspconfig.jedi_language_server.setup {on_attach = on_attach, capabilities = capabilities}

-- Golang LSP
lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
}
