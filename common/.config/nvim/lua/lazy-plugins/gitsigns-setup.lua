return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- Setup is stored in plugins/gitsigns-setup.lua
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    local keymap = vim.keymap.set
    local gs = require 'gitsigns'

    -- See `:help gitsigns.txt`
    gs.setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function()
        keymap('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[GS]: Next Hunk' })

        keymap('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[GS]: Previous Hunk' })

        -- Actions
        keymap('n', '<leader>hs', gs.stage_hunk, { desc = '[GS]: Stage Hunk' })
        keymap('n', '<leader>hr', gs.reset_hunk, { desc = '[GS]: Reset Hunk' })
        keymap('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[GS]: Stage Hunk' })
        keymap('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[GS]: Reset Hunk' })
        keymap('n', '<leader>hS', gs.stage_buffer, { desc = '[GS]: Stage Buffer' })
        keymap('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[GS]: Undo Stage Hunk' })
        keymap('n', '<leader>hR', gs.reset_buffer, { desc = '[GS]: Reset Buffer' })
        keymap('n', '<leader>hp', gs.preview_hunk, { desc = '[GS]: Preview Hunk' })
        keymap('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = '[GS]: Blame Line' })
        keymap('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[GS]: Toggle Blame Line' })
        keymap('n', '<leader>hd', gs.diffthis, { desc = '[GS]: Diff This' })
        keymap('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = '[GS]: Diff This' })
        keymap('n', '<leader>td', gs.toggle_deleted, { desc = '[GS]: Toggle Deleted' })
        -- Text object
        keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = '[GS]: Select Hunk' })
      end,
    }
  end,
}
