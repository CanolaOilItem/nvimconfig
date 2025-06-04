-- Setup Plugins
require("config.lazy")

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lsp")
-- Diagnostics
vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

-- Indent
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4
vim.opt["number"] = true
vim.opt["relativenumber"] = true

-- General Mappings
local map = vim.keymap.set
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

local builtin = require('telescope.builtin')
map("n", "<leader>fh", builtin.highlights, { desc = "Find Highlights" })
