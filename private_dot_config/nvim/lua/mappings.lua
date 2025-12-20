require "nvchad.mappings"
local map = vim.keymap.set

-- Feeco's custom mappings
map("n", "O", "o<ESC>")
map({ "n", "v" }, "E", "g_")
map("o", "E", "g_")
map("n", "B", "0")

-- Jump to first alphabetic character
map({ "n", "v", "o" }, "w", function()
    vim.fn.search([[\v<\a]], "W")
end, { desc = "Jump to next English lettet, not punctuation." })

-- Jump to first alphabetic character on next line
map({ "n", "v", "o" }, "W", function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    
    -- Check if we're not on the last line
    if current_line < total_lines then
        -- Move to next line without modifying search history
        vim.fn.cursor(current_line + 1, 1)
        -- Search from beginning of line
        vim.fn.search([[\a]], "c", current_line + 1)
    else
        -- Optionally: provide feedback or wrap to first line
        vim.notify("Already at last line", vim.log.levels.INFO)
    end
end, { desc = "Jump to first English letter of the next line" })

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
map({ "n", "i", "v" }, "<A-K>", "<C-o>", { desc = "go to last position" })
-- Open forward file
map({ "n", "i", "v" }, "<A-J>", "<C-i>", { desc = "go to forward position" })
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
map("n", "<A-;>", "<cmd>Telescope jumplist<CR>", { desc = "show jumplist" })
