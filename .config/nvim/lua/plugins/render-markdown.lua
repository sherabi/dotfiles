vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", version = "main" },
})

require("render-markdown").setup({
  -- Otherwise the language icon shows once inline and again in the sign column.
  code = { sign = false },
})
