vim.pack.add({
  { src = "https://github.com/nvimtools/none-ls.nvim", version = "main" },
})

local registry = require("mason-registry")
for _, name in ipairs({ "stylua", "hadolint", "yamllint", "ansible-lint", "shfmt", "shellcheck", "prettierd" }) do
  local ok, pkg = pcall(registry.get_package, name)
  if ok and not pkg:is_installed() and not pkg:is_installing() then
    pkg:install()
  end
end

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "less", "html", "markdown", "yaml" },
    }),
    null_ls.builtins.diagnostics.hadolint, -- Dockerfile
    null_ls.builtins.diagnostics.yamllint, -- plain yaml (not helm/yaml.ansible)
  },
})
