-- Various Top-level VIM options
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Always relnum!!
vim.o.relativenumber = false

-- Light coloured width marker
vim.o.colorcolumn = '100'

-- background (should be supported by colorscheme)
vim.o.background = 'dark'

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
