return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript", "typescript",
        "python", "json", "markdown"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- feeco's plugins
  -- file auto save
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup {
        enabled = true,
        execution_message = {
          message = function()
            return ""  -- disable save messages
          end,
        },
        debounce_delay = 135,
      }
    end,
  },
  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
}
