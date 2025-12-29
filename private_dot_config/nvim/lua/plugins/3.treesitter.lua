return {
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
}
