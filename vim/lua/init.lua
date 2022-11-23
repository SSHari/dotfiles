-- Impatient (Faster startups)
require("utils").prequire("impatient")

-- Setup base configuration
require("globals")
require("general")

-- Set up notifications
if pcall(require, "notify") then vim.notify = require("notify") end

-- Order matters
require("sai.plugins")
require("lsp")
require("sai.keymaps")

-- Local Configuration
require("utils").prequire({"sai.local", silent = true}).local_setup()
