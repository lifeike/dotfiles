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
  "ts_ls",
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

  ts_ls = {
    settings = {
      typescript = {
        format = { enable = true },
      },
      javascript = {
        format = { enable = true },
      },
    },
  },

}

return M

