-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "ayu_dark",
  transparency = true,
	hl_override = {
		CursorLine = { bg = '#4D4D4D' },
		CursorColumn = { bg = '#333333' },
	},
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    theme = "default",
    order = { "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
    modules = { f = "%F" },
  },
}

-- Load the custom feeco commands
require("feeco_custom_commands.git_reset").setup()

return M
