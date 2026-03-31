vim.defer_fn(function()
  local ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'just' }

  -- Install missing parsers
  local installed = require('nvim-treesitter.config').get_installed('parsers')
  local installed_set = {}
  for _, lang in ipairs(installed) do
    installed_set[lang] = true
  end
  local missing = {}
  for _, lang in ipairs(ensure_installed) do
    if not installed_set[lang] then
      table.insert(missing, lang)
    end
  end
  if #missing > 0 then
    require('nvim-treesitter.install').install(missing)
  end

  -- Textobjects
  local ts_select = require('nvim-treesitter-textobjects.select')
  local ts_move = require('nvim-treesitter-textobjects.move')
  local ts_swap = require('nvim-treesitter-textobjects.swap')

  require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
  })

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc })
  end

  -- Select textobjects
  map({ 'x', 'o' }, 'aa', function() ts_select.select_textobject('@parameter.outer') end, 'outer parameter')
  map({ 'x', 'o' }, 'ia', function() ts_select.select_textobject('@parameter.inner') end, 'inner parameter')
  map({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer') end, 'outer function')
  map({ 'x', 'o' }, 'if', function() ts_select.select_textobject('@function.inner') end, 'inner function')
  map({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer') end, 'outer class')
  map({ 'x', 'o' }, 'ic', function() ts_select.select_textobject('@class.inner') end, 'inner class')

  -- Move
  map({ 'n', 'x', 'o' }, ']m', function() ts_move.goto_next_start('@function.outer') end, 'Next function start')
  map({ 'n', 'x', 'o' }, ']]', function() ts_move.goto_next_start('@class.outer') end, 'Next class start')
  map({ 'n', 'x', 'o' }, ']M', function() ts_move.goto_next_end('@function.outer') end, 'Next function end')
  map({ 'n', 'x', 'o' }, '][', function() ts_move.goto_next_end('@class.outer') end, 'Next class end')
  map({ 'n', 'x', 'o' }, '[m', function() ts_move.goto_previous_start('@function.outer') end, 'Prev function start')
  map({ 'n', 'x', 'o' }, '[[', function() ts_move.goto_previous_start('@class.outer') end, 'Prev class start')
  map({ 'n', 'x', 'o' }, '[M', function() ts_move.goto_previous_end('@function.outer') end, 'Prev function end')
  map({ 'n', 'x', 'o' }, '[]', function() ts_move.goto_previous_end('@class.outer') end, 'Prev class end')

  -- Swap
  map('n', '<leader>a', function() ts_swap.swap_next('@parameter.inner') end, 'Swap next parameter')
  map('n', '<leader>A', function() ts_swap.swap_previous('@parameter.inner') end, 'Swap prev parameter')
end, 0)
