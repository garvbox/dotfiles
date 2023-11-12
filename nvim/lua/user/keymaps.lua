local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Reset cursor to center when scrolling
keymap('n', '<C-d>','<C-d>zz', opts)
keymap('n', '<C-u>','<C-u>zz', opts)

