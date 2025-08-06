require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--print-width", "100" },
    },
  },
  format_one_save = {
    timeout_ms = 5000, -- increase timeout to 5 seconds
  }
})
