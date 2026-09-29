vim.pack.add({
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", version = "main" },
})

require("render-markdown").setup({
  -- Otherwise the language icon shows once inline and again in the sign column.
  code = { sign = false },
  -- Parsers for these aren't installed; avoids checkhealth warnings.
  html = { enabled = false },
  latex = { enabled = false },
})
