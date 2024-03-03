-- Helper to shorten function name
local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable Arrows
keymap('n', '<Left>', '<nop>', { noremap = true, silent = true, desc = 'Disable Left Arrow nav' })
keymap('n', '<Right>', '<nop>', { noremap = true, silent = true, desc = 'Disable Right Arrow nav' })
keymap('n', '<Up>', '<nop>', { noremap = true, silent = true, desc = 'Disable Up Arrow nav' })
keymap('n', '<Down>', '<nop>', { noremap = true, silent = true, desc = 'Disable Down Arrow nav' })

-- Open Files
keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>', { desc = 'File Opener' })

-- Reset cursor to center when scrolling
keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true, desc = 'Scroll down with cursor reset' })
keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true, desc = 'Scroll up with cursor reset' })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
