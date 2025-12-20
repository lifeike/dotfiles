return {
  "neovim/nvim-lspconfig",
  ft = { "python", "ipynb" },
  config = function()
    vim.lsp.config("pyright", {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })
    vim.lsp.enable("pyright")
  end,
}


