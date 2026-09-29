vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim", version = "main" },
})

require("which-key").setup({})

require("which-key").add({
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>r", group = "Resize" },
  { "<leader>c", group = "Code" },
})
