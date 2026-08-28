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

-- Notes: thread ledger, journal, investigations (kv-workspace)
local vault = vim.fn.expand '~/projects/kv-workspace'
local ledger = vault .. '/THREADS.md'

-- Opens the monthly journal, ensures today's heading exists, cursor at the end
local function open_journal_today()
  local journal = ('%s/%s.md'):format(vault, os.date '%Y/%Y-%m')
  vim.fn.mkdir(vim.fs.dirname(journal), 'p')
  if vim.fn.expand '%:p' ~= journal then
    vim.cmd.edit(journal)
  end
  local heading = os.date '## %Y-%m-%d'
  if vim.fn.search('^' .. heading .. '$', 'nw') == 0 then
    local last = vim.api.nvim_buf_line_count(0)
    vim.api.nvim_buf_set_lines(0, last, last, false, { '', heading, '' })
  end
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
end

keymap('n', '<leader>nd', open_journal_today, { desc = 'Journal: today' })

keymap('n', '<leader>nf', function()
  require('telescope.builtin').live_grep { cwd = vault, prompt_title = 'Search notes' }
end, { desc = 'Search notes vault' })

keymap('n', '<leader>ni', function()
  vim.ui.input({ prompt = 'investigation: ' }, function(slug)
    if not slug or slug == '' then
      return
    end
    slug = slug:lower():gsub('%s+', '-'):gsub('[^%w%-]', '')
    local relpath = ('investigations/%s-%s.md'):format(os.date '%Y-%m-%d', slug)
    open_journal_today()
    local last = vim.api.nvim_buf_line_count(0)
    vim.api.nvim_buf_set_lines(0, last, last, false, { ('%s → %s'):format(slug, relpath) })
    vim.cmd.write()
    vim.fn.mkdir(vault .. '/investigations', 'p')
    vim.cmd.edit(vault .. '/' .. relpath)
    if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_get_current_line() == '' then
      vim.api.nvim_buf_set_lines(0, 0, 1, false, { '# ' .. slug, '' })
    end
  end)
end, { desc = 'New investigation note' })

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = ledger,
  group = vim.api.nvim_create_augroup('ThreadLedgerSweep', { clear = true }),
  callback = function()
    vim.system({ 'park', 'sweep' }, {}, vim.schedule_wrap(function()
      vim.cmd 'silent! checktime'
    end))
  end,
})
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
