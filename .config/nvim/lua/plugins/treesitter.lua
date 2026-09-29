-- Treesitter for code parsing (nvim-treesitter "main" branch; Nvim 0.12+ API)
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup {}

local parsers = {
  "yaml",
  "helm",
  "diff",
  "markdown",
  "markdown_inline",
  "lua",
  "json",
  "go",
  "bash",
  "toml",
  "dockerfile",
  "terraform",
  "hcl",
  "vim",
  "python",
  "javascript",
  "typescript",
  "tsx",
  "rust",
}
require("nvim-treesitter").install(parsers)

-- nvim-treesitter symlinks each parser's queries into stdpath('data')/site/queries/
-- rather than copying them; if the plugin's own directory ever moves (e.g. after
-- switching plugin managers, or its checkout gets renamed/deleted), "already
-- installed" parsers keep their .so but their query symlink goes dangling,
-- silently killing highlighting. Detect and force-repair on every start.
do
  local queries_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "queries")
  local broken = {}
  for _, lang in ipairs(parsers) do
    local highlights = vim.fs.joinpath(queries_dir, lang, "highlights.scm")
    if not vim.uv.fs_stat(highlights) then
      table.insert(broken, lang)
    end
  end
  if #broken > 0 then
    vim.notify("nvim-treesitter: repairing dangling query link(s) for " .. table.concat(broken, ", "), vim.log.levels.WARN)
    require("nvim-treesitter").install(broken, { force = true })
  end
end

-- Tree-sitter highlighting isn't auto-enabled on Nvim 0.12; opt in per filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  -- pcall: some filetypes (neo-tree, nui, ...) have no parser and start() asserts
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
