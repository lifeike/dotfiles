vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/lua/snippets/*.lua",
  callback = function()
    require("luasnip").cleanup()
    require("luasnip.loaders.from_lua").lazy_load()
  end
})
