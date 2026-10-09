-- No plugins need these remote-plugin hosts; disabling avoids checkhealth
-- noise and the startup cost of probing for them.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Display
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.signcolumn = "yes"
opt.showmatch = true
opt.showmode = false
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.fillchars = { eob = " " }
-- opt.winbar = "%f"

-- Windows and popups
opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Completion
opt.autocomplete = true
opt.complete = "o,w,b,u,t"
opt.completeopt = "menu,menuone,noselect,popup,nearest"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Files and undo
opt.swapfile = false
opt.undofile = true
opt.autoread = true

-- Behavior
opt.clipboard = "unnamedplus"
opt.updatetime = 300
-- Time allowed between keys of a mapping (default 1000); gives which-key
-- sequences like <Leader>r<Left> a little more room.
opt.timeoutlen = 1500

-- Autocmds
local augroup = vim.api.nvim_create_augroup("UserOptions", { clear = true })

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Skip commit/rebase buffers, where the saved position is meaningless.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "gitcommit" or ft == "gitrebase" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Create missing parent directories when saving to a new path.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(args)
    if args.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(args.file, ":p:h"), "p")
  end,
})

-- Re-equalize splits when the terminal or tmux pane is resized.
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "tabdo wincmd =",
})

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
