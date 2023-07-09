vim.g.mapleader = " "
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })
vim.keymap.set('v', '//', 'y/<C-R>"<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.o.clipboard = "unnamedplus,unnamed"

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

--Fix the errors in the sign column shifting the text by forcing sign column to 
--show always
vim.o.signcolumn="yes"

--Prettier
vim.g['prettier#autoformat'] = 1
vim.g['prettier#config#use_tabs'] = 1
vim.g['prettier#config#tab_width'] = 2

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

require('plugins')

