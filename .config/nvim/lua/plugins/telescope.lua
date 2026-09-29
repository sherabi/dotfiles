vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", version = "main" },
  { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.2" },
  { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim", version = "master" },
})

require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})
require("telescope").load_extension("ui-select")
