return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  opts = {
    -- Priority list of backends for aerial to use
    backends = { "lsp", "treesitter" },  -- default
    filter_kind = false,                  -- show all symbols
    show_guides = true,
    layout = {
      max_width = { 50, 0.2 },
      min_width = 30,
    },
  },
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}
