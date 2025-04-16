require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--print-width", "200" },
    },
  },
})

