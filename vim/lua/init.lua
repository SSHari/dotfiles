-- Order matters
require("globals")
require("general")
require("sai.plugins")
require("lsp")
require("sai.keymaps")

-- Local Configuration
require("utils").prequire({module = "sai.local", silent = true}).local_setup()
