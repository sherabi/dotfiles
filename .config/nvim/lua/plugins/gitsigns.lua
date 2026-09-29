vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = "main" },
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})
