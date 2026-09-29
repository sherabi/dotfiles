vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

-- General nvim keymap overrides
keymap.set('n', '<C-w>', '<Nop>', { desc = "Remap C-w to nothing" })
keymap.set("n", "<Leader>w", "<C-w>", { desc = "Remap C-w to Leader-w to move around splits" })

keymap.set("n", "<Leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<Leader>x", ":x<CR>", { desc = "Save and quit" })
keymap.set("n", "<Leader>s", ":up<CR>", { desc = "Save only if there is a change to the file" })
keymap.set("n", "<Leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
keymap.set({"n", "v"}, "<leader>d", [["_d]],{ desc = "Delete without yanking" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves lines down in visual selection" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves lines up in visual selection" })
keymap.set("v", "<", "<gv", {desc = "Unindent and keep selection"})
keymap.set("v", ">", ">gv", {desc = "Indent and keep selection"})

-- Simple resize: Space + r + arrow keys
keymap.set("n", "<Leader>r<Left>", ":vertical resize -3<CR>", { desc = "Resize left" })
keymap.set("n", "<Leader>r<Down>", ":resize +3<CR>", { desc = "Resize down" })
keymap.set("n", "<Leader>r<Up>", ":resize -3<CR>", { desc = "Resize up" })
keymap.set("n", "<Leader>r<Right>", ":vertical resize +3<CR>", { desc = "Resize right" })

-- Window management shortcuts
keymap.set("n", "<Leader>r=", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<Leader>r_", "<C-w>_", { desc = "Maximize height" })
keymap.set("n", "<Leader>r|", "<C-w>|", { desc = "Maximize width" })

-- Native Nvim 0.12 runtime packages (bundled, but not loaded until :packadd)
keymap.set("n", "<Leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end, { desc = "Toggle undo tree" })

keymap.set("n", "<Leader>D", function()
  vim.cmd.packadd("nvim.difftool")
  vim.api.nvim_feedkeys(":DiffTool ", "n", false)
end, { desc = "Diff two files/directories" })

-- LSP & diagnostics (lua/plugins/lsp-config.lua, lua/plugins/none-ls.lua)
keymap.set("n", "K", vim.lsp.buf.hover, {})
keymap.set("n", "gd", vim.lsp.buf.definition, {})
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
keymap.set("n", "<leader>cd", function()
  vim.diagnostic.setloclist()
end, { desc = "Diagnostics list (buffer)" })
keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Telescope (lua/plugins/telescope.lua)
keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    find_command = { "sh", "-c", "fd --type f --hidden --strip-cwd-prefix | sort" },
  })
end, { desc = "Find files" })
keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
end, { desc = "Live grep" })
keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Show buffers" })

-- Neo-tree (lua/plugins/neotree.lua)
keymap.set("n", "<leader>t", ":Neotree<CR>", {})

-- FTerm (lua/plugins/fterm.lua)
keymap.set("n", "<leader>;", '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set("t", "<leader>;", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- nvim-hlslens (lua/plugins/hlslens.lua)
keymap.set("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require("hlslens").start()<CR>]], { desc = "Next search match" })
keymap.set("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require("hlslens").start()<CR>]], { desc = "Previous search match" })
keymap.set("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], { desc = "Search word under cursor" })
keymap.set("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]], { desc = "Search word under cursor backwards" })
keymap.set("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]], { desc = "Search partial word under cursor" })
keymap.set("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]], { desc = "Search partial word under cursor backwards" })

-- Wildmenu completion binds prev/next match to <Left>/<Right> by default,
-- reserving <Up>/<Down> for filename/menu navigation (see 'wildmenu' in
-- :h options.txt). Use <Up>/<Down> to cycle matches instead.
keymap.set("c", "<Down>", function()
  return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
end, { expr = true })
keymap.set("c", "<Up>", function()
  return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
end, { expr = true })
