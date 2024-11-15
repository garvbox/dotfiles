return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  }
}
