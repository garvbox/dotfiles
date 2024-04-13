return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, bufnr)
        return vim.startswith(name, '__pycache__')
      end,
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
