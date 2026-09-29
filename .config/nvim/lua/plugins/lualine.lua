vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim", version = "master" },
})

require("lualine").setup({
  options = {
    theme = "catppuccin-mocha",
    globalstatus = true,
    icons_enabled = false,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 3 } },
  },
})
