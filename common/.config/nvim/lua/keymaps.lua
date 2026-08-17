-- Helper to shorten function name
local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable Arrows
keymap('n', '<Left>', '<nop>', { noremap = true, silent = true, desc = 'Disable Left Arrow nav' })
keymap('n', '<Right>', '<nop>', { noremap = true, silent = true, desc = 'Disable Right Arrow nav' })
keymap('n', '<Up>', '<nop>', { noremap = true, silent = true, desc = 'Disable Up Arrow nav' })
keymap('n', '<Down>', '<nop>', { noremap = true, silent = true, desc = 'Disable Down Arrow nav' })

-- File Switcher
keymap('n', '<leader><leader>', '<C-^>', { desc = 'Switch between last two files' })

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

-- Paste helpers for clean buffers
-- " delete without yanking
-- nnoremap <leader>d "_d
-- vnoremap <leader>d "_d
keymap('n', '<leader>d', '"_d', { desc = 'Delete without yanking' })
keymap('v', '<leader>d', '"_d', { desc = 'Delete without yanking' })
keymap('n', '<leader>p', '"_dP', { desc = 'Paste without yanking' })

-- Oil open
keymap('n', '<leader>o', function() require('oil').toggle_float() end, { desc = '[O]il file browser' })

-- Thread ledger
local ledger = vim.fn.expand '~/projects/kv-workspace/THREADS.md'
keymap('n', '<leader>np', function()
  local file = vim.fn.expand '%:.'
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local root = vim.fs.root(0, '.git')
  local repo = root and vim.fs.basename(root) or vim.fs.basename(vim.uv.cwd())
  local ctx = os.date '%Y-%m-%d %H:%M' .. ' · ' .. repo
  if vim.b.gitsigns_head then
    ctx = ctx .. '@' .. vim.b.gitsigns_head
  end
  if file ~= '' then
    ctx = ctx .. ' · ' .. file .. ':' .. line
  end
  vim.ui.input({ prompt = 'park: ' }, function(thought)
    if not thought or thought == '' then
      return
    end
    local f = assert(io.open(ledger, 'a'))
    f:write(('- [ ] %s — %s\n'):format(ctx, thought))
    f:close()
  end)
end, { desc = 'Park thought in thread ledger' })
keymap('n', '<leader>nl', function()
  local buf = vim.fn.bufadd(ledger)
  vim.bo[buf].buflisted = true
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.7),
    row = math.floor(vim.o.lines * 0.12),
    col = math.floor(vim.o.columns * 0.1),
    border = 'rounded',
  })
  vim.cmd 'normal! G'
end, { desc = 'Open thread ledger' })

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
