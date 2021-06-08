-- Local Variables and Functions
USER = vim.fn.expand("$USER")

local on_attach_vim = function(client)
    require'completion'.on_attach(client)
end

local get_path_with_home = function(path)
    return "/home/" .. USER .. "/" .. path
end

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true
    })

-- LSP Setup
require'lspconfig'.elixirls.setup {
    cmd = {
        get_path_with_home(".vim/language-servers/elixir-ls/language_server.sh")
    },
    on_attach = on_attach_vim
}

require'lspconfig'.tsserver.setup {on_attach = on_attach_vim}

local sumneko_root_path = get_path_with_home(".config/nvim/lua-language-server")
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

local lua_format = get_path_with_home(
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

-- TreeSitter Setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"lua", "tsx", "typescript"},
    highlight = {enable = true},
    indent = {enable = true}
}
