vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
})

local icons = require("mini.icons")
icons.setup({})
-- neo-tree's default icon provider hardcodes require("nvim-web-devicons");
-- this shim satisfies that call without needing the real plugin installed.
icons.mock_nvim_web_devicons()
