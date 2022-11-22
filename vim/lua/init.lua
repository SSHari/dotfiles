-- Order matters
require("globals")
require("general")
require("sai.plugins")
require("lsp")
require("sai.keymaps")

-- Local Configuration
require("utils").prequire({"sai.local", silent = true}).local_setup()
