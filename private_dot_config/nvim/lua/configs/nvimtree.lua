local api = require("nvim-tree.api")

require("nvim-tree").setup {
  disable_netrw = true,
  hijack_netrw = true,
  
  on_attach = function(bufnr)
    -- Load default mappings first
    api.config.mappings.default_on_attach(bufnr)
    
    -- Then override Ctrl+E specifically
    vim.keymap.set("n", "<C-e>", function()
      require("nvim-tree.api").tree.toggle()
    end, {
      desc = "Toggle NvimTree",
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end,
  
  view = {
    width = 30,
    side = "left",
  },
  
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
  
  filters = {
    dotfiles = false,
    custom = { "^.git$" },
  },
  
  git = {
    enable = true,
    ignore = false,
  },
}
