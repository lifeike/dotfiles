return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  opts = require "configs.conform",
}
