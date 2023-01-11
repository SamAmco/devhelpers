--Common settings
vim.g.mapleader = " "
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })
vim.keymap.set('v', '//', 'y/<C-R>"<CR>')
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap('i', '<C-f>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
vim.o.clipboard = "unnamedplus,unnamed"

-- Set the color scheme
require('onedark').setup {
	-- options are dark, darker, cool, deep, warm and warmer
	style = 'dark'
}
require('onedark').load()
