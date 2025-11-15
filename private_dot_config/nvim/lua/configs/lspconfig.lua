-- load NvChad defaults (lua_ls etc)
require("nvchad.configs.lspconfig").defaults()

-- NEW: compatibility shim for Neovim 0.11+
-- makes lspconfig.setup still work without errors
local lspconfig = vim.lsp.config

local nvlsp = require "nvchad.configs.lspconfig"

-- List of servers to enable
local servers = { "html", "cssls", "pyright", "ts_ls" }

-- Setup each server with defaults
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Optional: Custom Pyright settings
lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- Optional: Custom TypeScript/JavaScript settings
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    typescript = { format = { enable = true } },
    javascript = { format = { enable = true } },
  },
}

