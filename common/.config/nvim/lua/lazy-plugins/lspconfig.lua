return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "mason-org/mason.nvim",           version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    'j-hui/fidget.nvim',
  },
}
