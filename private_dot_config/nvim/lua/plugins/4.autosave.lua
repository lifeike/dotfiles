return {
  "Pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChangedI" },
  config = function()
    require("auto-save").setup {
      enabled = true,
      execution_message = { message = "" },
      debounce_delay = 135,
    }
  end,
}
