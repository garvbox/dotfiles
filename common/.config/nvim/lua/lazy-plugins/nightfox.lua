return {
  'EdenEast/nightfox.nvim',
  name = 'nightfox',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme 'carbonfox'
  end,
}
