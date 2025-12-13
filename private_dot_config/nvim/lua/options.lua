require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline and row number!
o.cursorcolumn =false   -- I tried vertical cursor line, finally disable it, cuz looks weird


-- Open nvim-tree automatically when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      require("nvim-tree.api").tree.open()
    end
  end,
})

-- other customizations
-- clipboard
vim.opt.clipboard = "unnamedplus"
