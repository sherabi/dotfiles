vim.pack.add({
  { src = "https://github.com/qvalentin/helm-ls.nvim", version = "main" },
})

-- These features are gated behind an explicit setup() call in the plugin
-- itself; without it (as before) they silently never activate.
require("helm-ls").setup({
  conceal_templates = { enabled = true }, -- experimental: show resolved values instead of {{ .Values.x }}
  indent_hints = { enabled = true, only_for_current_line = true }, -- experimental: show effect of nindent/indent
  action_highlight = { enabled = true }, -- highlight the current if/with/range block
})

-- Recommended by helm-ls.nvim for correct handling of wrapped conceal_templates lines
vim.opt.conceallevel = 2
