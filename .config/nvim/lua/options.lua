-- No plugins need these remote-plugin hosts; disabling avoids checkhealth
-- noise and the startup cost of probing for them.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.termguicolors = true
opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.winborder = "rounded"
opt.autocomplete = true
opt.complete = "o,w,b,u,t"
opt.completeopt = "menu,menuone,noselect,popup,nearest"
opt.pumborder = "rounded"
-- opt.winbar = "%f"
opt.background = "dark"

-- 'ignorecase' also applies to |cmdline-completion| (:h 'ignorecase'), so
-- ":<Tab>" was matching both "t..." and "T..." commands. Keep ignorecase
-- for search, but turn it off while on the ":" command-line so completion
-- stays case-sensitive there.
local ignorecase_before_cmdline
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = ":",
  callback = function()
    ignorecase_before_cmdline = vim.o.ignorecase
    vim.o.ignorecase = false
  end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = ":",
  callback = function()
    vim.o.ignorecase = ignorecase_before_cmdline
  end,
})

-- Only show the 80-column guide when some line in the buffer actually
-- crosses it, instead of a permanent vertical line down the whole buffer.
-- Uses Vim's own (C-implemented) search rather than a Lua loop over every
-- line, so it stays cheap even on large files.
local function has_long_line()
  local view = vim.fn.winsaveview()
  vim.fn.cursor(1, 1)
  local found = vim.fn.search([[\%>80v]], "cnW") ~= 0
  vim.fn.winrestview(view)
  return found
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TextChanged", "TextChangedI" }, {
  callback = function()
    vim.wo.colorcolumn = has_long_line() and "80" or ""
  end,
})
