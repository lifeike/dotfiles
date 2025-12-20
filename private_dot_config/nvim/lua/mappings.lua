require "nvchad.mappings"
local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "O", "o<ESC>")
map({ "n", "v" }, "E", "g_")
map("o", "E", "g_")
map("n", "W", "+")
map("n", "B", "0")

-- Feeco's custom mappings
-- Telescope
map({ "n", "i", "v" }, "<A-,>", "<cmd>Telescope<CR>", { desc = "show all list pickers" })
-- Telescope Commands
map({ "n", "i", "v" }, "<A-.>", "<cmd>Telescope commands<CR>", { desc = "show all commands in telescope" })

-- File Navigation

-- Telescope Find Files
map({ "n", "i", "v" }, "<A-i>", "<cmd>Telescope find_files<CR>", { desc = "find files" })
-- Find Defination
map({ "n", "i", "v" }, "<A-I>", "<C-]>", { desc = "find defination" })
-- Open last file
map({ "n", "i", "v" }, "<A-0>", "<C-o>", { desc = "go to last position" })
-- Open forward file
map({ "n", "i", "v" }, "<A-9>", "<C-i>", { desc = "go to forward position" })
-- Telescope list document symbols
map({ "n", "i", "v" }, "<A-d>", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "list symbols in a file" })
-- Telescope Find Occurrence
map({ "n", "i", "v" }, "<A-f>", "<cmd>Telescope live_grep<CR>", { desc = "search a text globally inside a project" })


-- Editing
-- Save and Format Files
map("n", "<A-s>", function()
  vim.cmd("w")
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })
-- close tabe
map({ "n", "i", "v" }, "<A-w>", "<cmd>bp<bar>bd#<CR>", { desc = "close current buffer safely" })
-- quit
map({ "n" }, "q", "<cmd>wqa<CR>", { desc = "quit neovim" })

-- Termninal
map({ "n", "t", "i", "v" }, "<A-Space>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map({ "n", "t" }, "<A-S-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-S-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

-- Navigation
map("n", "J", "10j", { desc = "shift+j jump 10 lines down" })
map("n", "K", "10k", { desc = "shift+k jump 10 lines up" })
map("n", "M", "J", { desc = "join current line with the next" })

-- toggle comments
map("n", "<A-c>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<A-c>", "gc", { desc = "toggle comment", remap = true })

-- focus file explorer
-- Map Ctrl+E to NvimTreeFocus in normal mode
map("n", "<C-f>", "<cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
map("i", "<C-f>", "<Esc><cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })

-- show jump list
map("n", "<A-;>", "<cmd>Telescope jumplist<CR>", { desc = "switch window" })
