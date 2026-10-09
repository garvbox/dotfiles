local M = {}

function M.set(specs)
  for _, spec in ipairs(specs) do
    local lhs = spec[1]
    local rhs = spec[2] or '<Nop>'
    local mode = spec.mode or 'n'
    local opts = vim.tbl_extend('force', {}, spec)
    opts[1], opts[2], opts.mode = nil, nil, nil
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  return M
end

return M
