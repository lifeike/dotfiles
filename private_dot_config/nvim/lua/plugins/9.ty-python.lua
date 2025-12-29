return {
  "neovim/nvim-lspconfig",
  ft = { "python", "ipynb" },
  config = function()
    local lspconfig = require "lspconfig"

    -- Add ty server configuration
    local configs = require "lspconfig.configs"
    if not configs.ty then
      configs.ty = {
        default_config = {
          cmd = { "ty", "server" },
          filetypes = { "python" },
          root_dir = function(fname)
            return lspconfig.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git")(
              fname
            ) or lspconfig.util.path.dirname(fname)
          end,
          settings = {},
        },
      }
    end

    lspconfig.ty.setup {
      settings = {
        ty = {},
      },
    }
  end,
}
