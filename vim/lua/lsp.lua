-- Local Variables and Functions
local lspconfig = require('lspconfig')
local utils = require('utils')

local on_attach = function(client, bufnr)
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
        return '<cmd>lua vim.lsp.diagnostic.' .. command .. '()<CR>'
    end

    -- Mappings
    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', '<leader>g', buf_cmd('definition'), opts)
    buf_set_keymap('n', '<leader>i', buf_cmd('hover'), opts)
    buf_set_keymap('n', '<leader>d', diagnostic_cmd('show_line_diagnostics'), opts)
    buf_set_keymap('n', '<leader>dp', diagnostic_cmd('goto_prev'), opts)
    buf_set_keymap('n', '<leader>dn', diagnostic_cmd('goto_next'), opts)

    -- Enable manual completion via <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Enable auto completion
    require'completion'.on_attach(client)
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {underline = true, virtual_text = false, signs = true, update_in_insert = true})

-- Elixir LSP
lspconfig.elixirls.setup {
    cmd = {utils.get_path_with_home(".config/nvim/elixirls/language_server/language_server.sh")},
    on_attach = on_attach
}

-- TypeScript LSP
lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        -- Disable typescript formatting in favor of prettier
        client.resolved_capabilities.document_formatting = false

        on_attach(client, bufnr)
    end,
    settings = {documentFormatting = false}
}

-- Lua LSP
local sumneko_root_path = utils.get_path_with_home(".config/nvim/lua-language-server")
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
lspconfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

-- EFM LSP
local lua_format = utils.get_path_with_home(
                       ".asdf/installs/lua/5.4.3/luarocks/lib/luarocks/rocks-5.4/luaformatter/scm-1/bin/lua-format")
local prettier = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}"

local efm_languages = {
    lua = {
        {
            formatCommand = lua_format
                .. " -i --no-keep-simple-function-one-line --column-limit=100 --no-break-after-operator --break-after-table-lb",
            formatStdin = true
        }
    },
    typescript = {{formatCommand = prettier, formatStdin = true}},
    typescriptreact = {{formatCommand = prettier, formatStdin = true}}
}

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(efm_languages),
    settings = {rootMarkers = {".git/", "package.json"}, languages = efm_languages}
}

-- Vim LSP
lspconfig.vimls.setup {on_attach = on_attach}
