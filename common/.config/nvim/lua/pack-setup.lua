vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  'https://github.com/EdenEast/nightfox.nvim',
  'https://github.com/catppuccin/nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/folke/tokyonight.nvim',

  'https://github.com/echasnovski/mini.nvim',

  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/b0o/SchemaStore.nvim',

  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',

  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/neovim/nvim-lspconfig',

  { src = 'https://github.com/L3MON4D3/LuaSnip', version = 'v2.4.1' },
  'https://github.com/folke/lazydev.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.1' },

  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/rcarriga/nvim-notify',
  'https://github.com/folke/noice.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/trouble.nvim',

  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',

  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/folke/persistence.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',

  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/rouge8/neotest-rust',

  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/dstein64/vim-startuptime',
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local name = ev.data and ev.data.name
    if name == 'nvim-treesitter' then
      vim.cmd 'TSUpdate'
    elseif name == 'telescope-fzf-native.nvim' then
      local dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt', 'telescope-fzf-native.nvim')
      if vim.fn.executable 'make' == 1 and vim.fn.isdirectory(dir) == 1 then
        vim.fn.system { 'make', '-C', dir }
      end
    elseif name == 'LuaSnip' then
      local dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt', 'LuaSnip')
      if vim.fn.executable 'make' == 1 and vim.fn.isdirectory(dir) == 1 then
        vim.fn.system { 'make', 'install_jsregexp', '-C', dir }
      end
    end
  end,
})

vim.cmd.colorscheme 'carbonfox'

require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.statusline').setup {
  use_icons = vim.g.have_nerd_font,
}

vim.api.nvim_create_autocmd('UIEnter', {
  once = true,
  callback = function()
    require 'plugins.lspconfig'
    require 'plugins.telescope'
    require 'plugins.gitsigns'
    require 'plugins.blink'
    require 'plugins.neotest'

    require('which-key').setup()
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    }

    require('todo-comments').setup {
      signs = true,
      keywords = {
        SAFETY = { icon = ' ', color = 'warning' },
      },
    }

    require('flash').setup {}
    vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
      require('flash').jump()
    end, { desc = 'Flash' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
      require('flash').treesitter()
    end, { desc = 'Flash Treesitter' })
    vim.keymap.set('o', 'r', function()
      require('flash').remote()
    end, { desc = 'Remote Flash' })
    vim.keymap.set({ 'o', 'x' }, 'R', function()
      require('flash').treesitter_search()
    end, { desc = 'Treesitter Search' })
    vim.keymap.set('c', '<c-s>', function()
      require('flash').toggle()
    end, { desc = 'Toggle Flash Search' })

    require('trouble').setup {}
    vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
    vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
    vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
    vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
    vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
    vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

    require('conform').setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    }

    require('oil').setup {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return vim.startswith(name, '__pycache__')
        end,
      },
    }

    require('noice').setup {}
    require('persistence').setup {}
    vim.keymap.set('n', '<leader>qs', function()
      require('persistence').load()
    end, { desc = 'Restore session' })
    vim.keymap.set('n', '<leader>qS', function()
      require('persistence').select()
    end, { desc = 'Select session' })
    vim.keymap.set('n', '<leader>ql', function()
      require('persistence').load { last = true }
    end, { desc = 'Restore last session' })
    vim.keymap.set('n', '<leader>qd', function()
      require('persistence').stop()
    end, { desc = 'Stop persistence' })
    require('nvim-autopairs').setup {}
    require('ibl').setup {}
    require('fidget').setup {}
    require('lazydev').setup {}
    require('luasnip').setup {}
    require('render-markdown').setup {}

    vim.g.startuptime_tries = 10
  end,
})
