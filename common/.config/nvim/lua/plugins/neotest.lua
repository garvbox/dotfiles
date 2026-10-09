local Path = require 'plenary.path'
local nt = require 'neotest'

nt.setup {
  adapters = {
    require 'neotest-python' {
      is_test_file = function(file_path)
        if not vim.endswith(file_path, '.py') then
          return false
        end
        local elems = vim.split(file_path, Path.path.sep)
        local file_name = elems[#elems]
        return vim.startswith(file_name, 'test_') or vim.endswith(file_name, '_test.py') or vim.endswith(file_name, '_tests.py')
      end,
    },
    require 'neotest-rust',
  },
}

local keymap = require 'util.keymap'

-- stylua: ignore
keymap.set {
  { '<leader>t', '', desc = '+test' },
  { '<leader>tt', function() nt.run.run(vim.fn.expand '%') end, desc = 'Run File' },
  { '<leader>tT', function() nt.run.run(vim.uv.cwd()) end, desc = 'Run All Test Files' },
  { '<leader>tr', function() nt.run.run() end, desc = 'Run Nearest' },
  { '<leader>tl', function() nt.run.run_last() end, desc = 'Run Last' },
  { '<leader>ts', function() nt.summary.toggle() end, desc = 'Toggle Summary' },
  { '<leader>tO', function() nt.output_panel.toggle() end, desc = 'Toggle Output Panel' },
  { '<leader>tS', function() nt.run.stop() end, desc = 'Stop' },
  { '<leader>tw', function() nt.watch.toggle(vim.fn.expand '%') end, desc = 'Toggle Watch' },
}
