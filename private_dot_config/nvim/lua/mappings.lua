require "nvchad.mappings"


local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "O", "o<ESC>")
map({ "n", "v" }, "E", "g_")
map("o", "E", "g_")
map("n", "W", "+")
map("n", "B", "0")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Feeco's custom mappings
-- Telescope
map({ "n", "i", "v" }, "<A-,>", "<cmd>Telescope<CR>", { desc = "show all list pickers" })
-- Telescope Commands
map({ "n", "i", "v" }, "<A-.>", "<cmd>Telescope commands<CR>", { desc = "show all commands in telescope" })
-- Telescope Find Files
map({ "n", "i", "v" }, "<A-i>", "<cmd>Telescope find_files<CR>", { desc = "find files" })
-- Telescope Find Current Tabs
map({ "n" }, "t", "<cmd>Telescope buffers<CR>", { desc = "find current tabs", noremap = true, silent = true })
-- Telescope Find Occurrence
map({ "n", "i", "v" }, "<A-f>", "<cmd>Telescope live_grep<CR>", { desc = "search a text globally inside a project" })
-- Save and Format Files
map("n", "<A-s>", function()
  vim.cmd("w")
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })
-- close tabe
map({ "n", "i", "v" }, "<A-w>", "<cmd>bd<CR>", { desc = "close current tab" })
-- quit
map({ "n" }, "q", "<cmd>q<CR>", { desc = "quit neovim" })
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
map("n", "<C-e>", "<cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })

-- Optionally, in insert mode (press Esc first)
map("i", "<C-e>", "<Esc><cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
