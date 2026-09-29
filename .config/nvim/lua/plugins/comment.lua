vim.pack.add({
  { src = "https://github.com/numToStr/Comment.nvim", version = "master" },
})

-- Comment.nvim's own default mappings register both `gc`/`gb` (as motion
-- operators) and `gcc`/`gbc`/`gco`/`gcO`/`gcA` (as literal keys extending
-- that same prefix), which which-key's checkhealth flags as overlaps: typing
-- `gc` waits out 'timeoutlen' to see whether `gcc` etc. follows. Disabling
-- the defaults and remapping by hand avoids that: `gc`/`gb` stay pure
-- operators (use with a motion, e.g. `gcip`, or `gc_`/`gb_` for the current
-- line instead of `gcc`/`gbc`), and the insert-comment extras move under
-- <leader>c so they don't extend `gc` either.
require("Comment").setup({ mappings = false })

-- Neovim 0.12 ships its own native `gcc` default (vim._core.defaults), which
-- re-overlaps with `gc` the same way once Comment.nvim's own `gcc` is gone.
-- There's no native blockwise equivalent, so only `gcc` needs removing here.
pcall(vim.keymap.del, "n", "gcc")

local api = require("Comment.api")

vim.keymap.set("n", "gc", api.call("toggle.linewise", "g@"), { expr = true, desc = "Comment toggle linewise (motion; use gc_ for current line)" })
vim.keymap.set("n", "gb", api.call("toggle.blockwise", "g@"), { expr = true, desc = "Comment toggle blockwise (motion; use gb_ for current line)" })
vim.keymap.set("x", "gc", '<ESC><cmd>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())<CR>', { desc = "Comment toggle linewise (visual)" })
vim.keymap.set("x", "gb", '<ESC><cmd>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())<CR>', { desc = "Comment toggle blockwise (visual)" })

vim.keymap.set("n", "<leader>co", api.insert.linewise.below, { desc = "Comment insert below" })
vim.keymap.set("n", "<leader>cO", api.insert.linewise.above, { desc = "Comment insert above" })
vim.keymap.set("n", "<leader>ce", api.insert.linewise.eol, { desc = "Comment insert end of line" })
