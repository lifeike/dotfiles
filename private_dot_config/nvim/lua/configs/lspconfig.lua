-- Load NvChad's default LSP behavior (on_attach, capabilities, lua_ls, etc.)
local nvlsp = require("nvchad.configs.lspconfig")

-- Apply NvChad's defaults (must run)
nvlsp.defaults()

-- Export servers + per-server config overrides
local M = {}

-- Servers you want enabled
M.servers = {
  "html",
  "cssls",
  "pyright",
}

-- Per-server custom settings
M.config = {

  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },


}

return M

