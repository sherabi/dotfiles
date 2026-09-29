vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(args)
    local data = args.data
    if data.spec and data.spec.name == "telescope-fzf-native.nvim" and data.kind ~= "delete" then
      vim.system({ "make" }, { cwd = data.path }):wait()
    end
  end,
})

require("plugins.catppuccin")
require("plugins.mini-icons")
require("plugins.whichkey")
require("plugins.treesitter")
require("plugins.lsp-config")
require("plugins.telescope")
require("plugins.neotree")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.comment")
require("plugins.autopairs")
require("plugins.fterm")
require("plugins.none-ls")
require("plugins.tmux-navigator")
require("plugins.helm_ls")
require("plugins.render-markdown")
require("plugins.tiny-cmdline")
require("plugins.hlslens")
require("plugins.tabout")
