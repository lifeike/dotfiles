return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.config.set_config(opts)

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom Lua snippets
    require("luasnip.loaders.from_lua").load({
      paths = vim.fn.stdpath("config") .. "/lua/snippets",
    })
  end,
}

