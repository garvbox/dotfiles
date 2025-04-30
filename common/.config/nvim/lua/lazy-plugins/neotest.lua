local Path = require("plenary.path")
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  config = function()
    local keymap = vim.keymap.set
    local nt = require("neotest")

    nt.setup({
      adapters = {
        require("neotest-python")({
          is_test_file = function(file_path)
            if not vim.endswith(file_path, ".py") then
              return false
            end
            local elems = vim.split(file_path, Path.path.sep)
            local file_name = elems[#elems]
            return vim.startswith(file_name, "test_") or vim.endswith(file_name, "_test.py") or
                vim.endswith(file_name, "_tests.py")
          end
        }),
        require("neotest-rust"),
      },
    })

    -- Setup Keymaps
    keymap('n', "<leader>t", "", { desc = "+test" })
    keymap('n', "<leader>tt", function() nt.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
    keymap('n', "<leader>tT", function() nt.run.run(vim.uv.cwd()) end, { desc = "Run All Test Files" })
    keymap('n', "<leader>tr", function() nt.run.run() end, { desc = "Run Nearest" })
    keymap('n', "<leader>tl", function() nt.run.run_last() end, { desc = "Run Last" })
    keymap('n', "<leader>ts", function() nt.summary.toggle() end, { desc = "Toggle Summary" })
    -- keymap('n', "<leader>to", function() nt.output.open(keymap('n', enter = true, auto_close = true }) end, {desc = "Show Output"} )
    keymap('n', "<leader>tO", function() nt.output_panel.toggle() end, { desc = "Toggle Output Panel" })
    keymap('n', "<leader>tS", function() nt.run.stop() end, { desc = "Stop" })
    keymap('n', "<leader>tw", function() nt.watch.toggle(vim.fn.expand("%")) end,
      { desc = "Toggle Watch" })
  end,
}
