vim.pack.add({
  { src = "https://github.com/rachartier/tiny-cmdline.nvim", version = "main" },
})

require("vim._core.ui2").enable({})
-- cmdheight = 0 enables Neovim's native floating cmdline (ui2), which this
-- plugin repositions to the center of the screen instead of the bottom.
vim.o.cmdheight = 0

local cmdline = require("tiny-cmdline")

cmdline.setup({
  width = {
    value = "70%"
  },
})
