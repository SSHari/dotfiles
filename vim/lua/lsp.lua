-- Local Variables and Functions
local utils = require('utils')
local on_attach_vim = function(client)
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
require'lspconfig'.elixirls.setup {
    cmd = {
        utils.get_path_with_home(
            ".vim/language-servers/elixir-ls/language_server.sh")
    },
    on_attach = on_attach_vim
}

-- TypeScript LSP
require'lspconfig'.tsserver.setup {on_attach = on_attach_vim}

-- Lua LSP
local sumneko_root_path = utils.get_path_with_home(
                              ".config/nvim/lua-language-server")
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
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

local lua_format = utils.get_path_with_home(
                       ".asdf/installs/lua/5.4.3/luarocks/lib/luarocks/rocks-5.4/luaformatter/scm-1/bin/lua-format")
require'lspconfig'.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = lua_format
                        .. " -i --no-keep-simple-function-one-line --no-break-after-operator --break-after-table-lb",
                    formatStdin = true
                }
            }
        }
    }
}
