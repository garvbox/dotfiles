-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({
  -- Basic plugins with no setup listed here, ones with any setup functions or options are
  -- in lazy-plugins

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- JSON & YAML Schema Stores
  'b0o/SchemaStore.nvim',
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Include dependent modules
  { import = 'lazy-plugins' },
}, {})
