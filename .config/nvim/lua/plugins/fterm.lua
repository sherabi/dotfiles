vim.pack.add({
  { src = "https://github.com/numToStr/FTerm.nvim", version = "master" },
})

require("FTerm").setup({
  border = "rounded",
  dimensions = {
    height = 0.99,
    width = 0.99,
  },
})
