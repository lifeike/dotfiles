require "nvchad.mappings"


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Feeco's custom mappings
-- Telescope
map({"n","i","v"}, "<A-c>", "<cmd>Telescope<CR>", { desc = "show all commands in telescope" })
-- Telescope Find Files
map({"n","i","v"}, "<A-f>", "<cmd>Telescope find_files<CR>", { desc = "find files" })
-- General Find Files
map({"n","i","v"}, "<A-s>", "<cmd>w<CR>", { desc = "general save file" })
-- close tabe
map({"n","i","v"}, "<A-w>", "<cmd>bd<CR>", { desc = "close current tab" })
-- Termninal
map({ "n", "t","i","v" }, "<A-Space>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })
-- Navigation
map("n", "<C-j>", "10j",{ desc = "alt+j jump 10 lines down" })
map("n", "<C-k>", "10k",{ desc = "alt+k jump 10 lines up" })
