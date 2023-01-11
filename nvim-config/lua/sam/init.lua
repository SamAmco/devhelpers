vim.g.mapleader = " "
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

-- Set the color scheme
require('onedark').setup {
	-- options are dark, darker, cool, deep, warm and warmer
	style = 'dark'
}
require('onedark').load()
