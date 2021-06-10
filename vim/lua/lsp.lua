-- Local Variables and Functions
local lspconfig = require('lspconfig')
local utils = require('utils')

-- TODO: Attach the keybindings to the buffer here instead
local on_attach = function(client, bufnr)
    require'completion'.on_attach(client)
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true
    })

-- Elixir LSP
lspconfig.elixirls.setup {
    cmd = {
        utils.get_path_with_home(
            ".config/nvim/elixirls/language_server/language_server.sh")
    },
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
local sumneko_root_path = utils.get_path_with_home(
                              ".config/nvim/lua-language-server")
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
                .. " -i --no-keep-simple-function-one-line --no-break-after-operator --break-after-table-lb",
            formatStdin = true
        }
    },
    -- TODO: Replace CocPrettier with this, but figure out why this breaks Telescope in TypeScript projects...
    typescript = {{formatCommand = prettier, formatStdin = true}},
    typescriptreact = {{formatCommand = prettier, formatStdin = true}}
}

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(efm_languages),
    settings = {
        rootMarkers = {".git/", "package.json"},
        languages = efm_languages
    }
}
