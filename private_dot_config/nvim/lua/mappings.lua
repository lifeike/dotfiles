require "nvchad.mappings"


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Feeco's custom mappings
-- Telescope
map("n", "<A-t>", "<cmd>Telescope<CR>", { desc = "show all commands in telescope" })
map("i", "<A-t>", "<cmd>Telescope<CR>", { desc = "show all commands in telescope" })
map("v", "<A-t>", "<cmd>Telescope<CR>", { desc = "show all commands in telescope" })
-- Telescope Find Files
map("n", "<A-f>", "<cmd>Telescope find_files<CR>", { desc = "show all commands in telescope" })
map("i", "<A-f>", "<cmd>Telescope find_files<CR>", { desc = "show all commands in telescope" })
map("v", "<A-f>", "<cmd>Telescope find_files<CR>", { desc = "show all commands in telescope" })
