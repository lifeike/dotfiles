require "nvchad.mappings"


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "O", "o<ESC>")
map("n", "E", "g_")
map("n", "W", "+")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Feeco's custom mappings
-- Telescope
map({"n","i","v"}, "<C-o>", "<cmd>Telescope<CR>", { desc = "show all commands in telescope" })
-- Telescope Find Files
map({"n","i","v"}, "<A-i>", "<cmd>Telescope find_files<CR>", { desc = "find files" })
-- Telescope Find Occurrence
map({"n","i","v"}, "<A-f>", "<cmd>Telescope live_grep<CR>", { desc = "search a text globally inside a project" })
-- Save and Format Files
map("n", "<A-s>", function()
  vim.cmd("w")
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })
-- close tabe
map({"n","i","v"}, "<A-w>", "<cmd>bd<CR>", { desc = "close current tab" })
-- quit
map({"n"}, "q", "<cmd>bd<CR>", { desc = "close current tab" })
-- Termninal
map({ "n", "t","i","v" }, "<A-Space>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map({ "n", "t" }, "<A-S-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-S-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

-- Navigation
map("n", "<C-j>", "10j",{ desc = "alt+j jump 10 lines down" })
map("n", "<C-k>", "10k",{ desc = "alt+k jump 10 lines up" })
-- toggle comments
map("n", "<A-c>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<A-c>", "gc", { desc = "toggle comment", remap = true })
