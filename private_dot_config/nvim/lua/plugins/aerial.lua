return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  opts = {
    -- Priority list of backends for aerial to use
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = {
      max_width = { 40, 0.2 },
      min_width = 20,
    },
    show_guides = true,
  },
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}
