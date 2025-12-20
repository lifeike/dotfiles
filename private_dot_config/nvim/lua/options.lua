require "nvchad.options"

-- add yours here!
local o = vim.o

-- Cursor and display options
o.cursorlineopt = 'both' -- to enable cursorline and row number!
o.cursorcolumn = false   -- I tried vertical cursor line, finally disable it, cuz looks weird
o.scrolloff = 8          -- reasonable scrolloff for better navigation
o.number = true          -- show line numbers
o.swapfile = false       -- disable swap files

-- Open nvim-tree automatically when opening a directory (optimized)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      -- Defer tree opening to avoid blocking startup
      vim.defer_fn(function()
        require("nvim-tree.api").tree.open()
      end, 50)
    end
  end,
})

-- clipboard
vim.opt.clipboard = "unnamedplus"
