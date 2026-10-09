require('snacks').setup { scratch = {}, picker = {}, explorer = {} }
local keymap = require 'util.keymap'

-- stylua: ignore
keymap.set {
  -- Scratch
  { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
  { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },

  -- Top pickers
  { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
  { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
  { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },

  -- Find
  { '<leader>fb', function() Snacks.picker.buffers() end, desc = '[F]ind [B]uffers' },
  { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[F]ind [C]onfig File' },
  { '<leader>ff', function() Snacks.picker.files() end, desc = '[F]ind [F]iles' },
  { '<leader>fg', function() Snacks.picker.git_files() end, desc = '[F]ind [G]it Files' },
  { '<leader>fp', function() Snacks.picker.projects() end, desc = '[F]ind [P]rojects' },
  { '<leader>fr', function() Snacks.picker.recent() end, desc = '[F]ind [R]ecent' },

  -- Git
  { '<leader>gb', function() Snacks.picker.git_branches() end, desc = '[G]it [B]ranches' },
  { '<leader>gl', function() Snacks.picker.git_log() end, desc = '[G]it [L]og' },
  { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = '[G]it [L]og Line' },
  { '<leader>gs', function() Snacks.picker.git_status() end, desc = '[G]it [S]tatus' },
  { '<leader>gS', function() Snacks.picker.git_stash() end, desc = '[G]it [S]tash' },
  { '<leader>gd', function() Snacks.picker.git_diff() end, desc = '[G]it [D]iff (Hunks)' },
  { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = '[G]it Log [F]ile' },

  -- GitHub
  { '<leader>gp', function() Snacks.picker.gh_pr() end, desc = '[G]itHub [P]ull Requests (open)' },
  { '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, desc = '[G]itHub [P]ull Requests (all)' },
  { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = '[G]itHub [I]ssues (open)' },
  { '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, desc = '[G]itHub [I]ssues (all)' },

  -- Search
  { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
  { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
  { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
  { '<c-p>', function() Snacks.picker.files() end, desc = 'Search Files' },
  { '<leader>ss', function() Snacks.picker() end, desc = '[S]earch [S]elect Picker' },
  { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
  { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
  { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = '[S]earch Grep Open [B]uffers' },
  { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
  { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = '[S]earch Buffer [D]iagnostics' },
  { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
  { '<leader>sR', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
  { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files' },
  { '<leader>sb', function() Snacks.picker.buffers() end, desc = '[S]earch [B]uffers' },
  { '<leader>s"', function() Snacks.picker.registers() end, desc = '[S]earch ["] Registers' },
  { '<leader>sa', function() Snacks.picker.autocmds() end, desc = '[S]earch [A]utocmds' },
  { '<leader>sc', function() Snacks.picker.command_history() end, desc = '[S]earch [C]ommand History' },
  { '<leader>sC', function() Snacks.picker.commands() end, desc = '[S]earch [C]ommands' },
  { '<leader>sH', function() Snacks.picker.highlights() end, desc = '[S]earch [H]ighlights' },
  { '<leader>si', function() Snacks.picker.icons() end, desc = '[S]earch [I]cons' },
  { '<leader>sj', function() Snacks.picker.jumps() end, desc = '[S]earch [J]umps' },
  { '<leader>sl', function() Snacks.picker.loclist() end, desc = '[S]earch [L]ocation List' },
  { '<leader>sm', function() Snacks.picker.marks() end, desc = '[S]earch [M]arks' },
  { '<leader>sM', function() Snacks.picker.man() end, desc = '[S]earch [M]an Pages' },
  { '<leader>sq', function() Snacks.picker.qflist() end, desc = '[S]earch [Q]uickfix List' },
  { '<leader>su', function() Snacks.picker.undo() end, desc = '[S]earch [U]ndo History' },
  { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = '[S]earch LSP Workspace [S]ymbols' },
  { '<leader>/', function() Snacks.picker.lines() end, desc = 'Fuzzily search in current buffer' },
  { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
  { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },

  -- LSP
  { 'gd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
  { 'gD', function() Snacks.picker.lsp_declarations() end, desc = '[G]oto [D]eclaration' },
  { 'gr', function() Snacks.picker.lsp_references() end, desc = '[G]oto [R]eferences' },
  { 'gI', function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
  { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto T[y]pe Definition' },
  { 'gai', function() Snacks.picker.lsp_incoming_calls() end, desc = 'C[a]lls [I]ncoming' },
  { 'gao', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'C[a]lls [O]utgoing' },
  { '<leader>ds', function() Snacks.picker.lsp_symbols() end, desc = '[D]ocument [S]ymbols' },

  -- UI
  { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = '[U]I [C]olorschemes' },
}
