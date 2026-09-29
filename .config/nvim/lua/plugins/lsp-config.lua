vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim", version = "main" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig", version = "master" },
  { src = "https://github.com/b0o/schemastore.nvim" },
})

-- ansiblels (and none-ls's ansiblelint source) only ever activate on the
-- "yaml.ansible" filetype, which nothing detects by default -- without this,
-- ansiblels silently never attaches to a single buffer despite being
-- enabled and configured below. Same story for yamlls' "yaml.docker-compose"
-- / "yaml.gitlab" and gopls' "gotmpl".
vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/(playbook|site)%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*"] = "yaml.ansible",
    [".*/host_vars/.*"] = "yaml.ansible",
    [".*docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
    [".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
  },
})

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ansiblels",
    "bashls",
    "dockerls",
    "gopls",
    "helm_ls",
    "jsonls",
    "yamlls",
    "taplo",
    "terraformls",
    "vimls",
    "basedpyright",
    "ruff",
    "ts_ls",
    "eslint",
    "golangci_lint_ls",
    "rust_analyzer",
  },
})

vim.lsp.config.lua_ls = {}
vim.lsp.config.ansiblels = {}
vim.lsp.config.bashls = {}
vim.lsp.config.dockerls = {}
vim.lsp.config.gopls = {}
vim.lsp.config.jsonls = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
vim.lsp.config.yamlls = {
  settings = {
    yaml = {
      -- use schemastore.nvim's catalog instead of yamlls' built-in one, which
      -- only refreshes on release rather than tracking schemastore.nvim's repo
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
vim.lsp.config.taplo = {}
vim.lsp.config.terraformls = {}
vim.lsp.config.vimls = {}
vim.lsp.config.basedpyright = {
  settings = {
    basedpyright = {
      -- ruff handles import sorting/organizing; avoid the two fighting over it
      disableOrganizeImports = true,
      analysis = {
        -- ruff (F401/F841) already flags these; keep basedpyright's own
        -- type-checking diagnostics without duplicating ruff's lint findings.
        -- Note: basedpyright doesn't read the legacy "python.*" settings
        -- namespace at all -- must be under "basedpyright.*".
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportUnusedVariable = "none",
        },
      },
    },
  },
}
vim.lsp.config.ruff = {
  on_attach = function(client)
    -- basedpyright's hover is more feature-rich (types, docs); avoid duplicate hover
    client.server_capabilities.hoverProvider = false
  end,
}
vim.lsp.config.ts_ls = {}
vim.lsp.config.eslint = {}
vim.lsp.config.golangci_lint_ls = {}
-- Mason-managed rather than the rustup component (mason.nvim prepends its
-- bin dir to $PATH, so this takes precedence over ~/.cargo/bin/rust-analyzer).
vim.lsp.config.rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      -- clippy is a strict superset of the default "check" diagnostics
      check = { command = "clippy" },
    },
  },
}

-- golangci-lint isn't an LSP server, so mason-lspconfig's ensure_installed
-- above doesn't cover it, but golangci_lint_ls shells out to it directly.
do
  local registry = require("mason-registry")
  local ok, pkg = pcall(registry.get_package, "golangci-lint")
  if ok and not pkg:is_installed() and not pkg:is_installing() then
    pkg:install()
  end
end

vim.lsp.config.helm_ls = {
  settings = {
    ["helm-ls"] = {
      yamlls = {
        -- installed as a side effect of yamlls being in ensure_installed above
        path = "yaml-language-server",
      },
      enabledDiagnostics = false,
      lint = {
        enable = false
      }
    },
  },
}

vim.lsp.enable({
  'lua_ls', 'ansiblels', 'bashls', 'dockerls', 'gopls', 'helm_ls', 'jsonls',
  'yamlls', 'taplo', 'terraformls', 'vimls', 'basedpyright', 'ruff', 'ts_ls',
  'eslint', 'golangci_lint_ls', 'rust_analyzer',
})

-- Native LSP completion (no completion plugin needed on Nvim 0.12+): pairs
-- with 'autocomplete'/'complete' in options.lua for automatic buffer+LSP
-- popups, and adds trigger-character awareness plus snippet expansion on accept.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
