vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs", version = "master" },
})

require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "text" },
})
