return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require "configs.lspconfig"
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
        "python", "json",
        "markdown", "markdown_inline",
      },
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "markdown" },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- feeco's plugins
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChangedI" },
    config = function()
      require("auto-save").setup {
        enabled = true,
        execution_message = { message = "" },
        debounce_delay = 135,
      }
    end,
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
}
