vim.pack.add({
  { src = "https://github.com/numToStr/Comment.nvim", version = "master" },
})

local function pre_hook(ctx)
  local ok, parser = pcall(vim.treesitter.get_parser)
  if ok and parser then
    local Ft = require("Comment.ft")
    local range = ctx.range
    local lang = Ft.contains(parser, { range.srow - 1, range.scol, range.erow - 1, range.ecol }):lang()
    local cstr = Ft.get(lang, ctx.ctype)
    if cstr then
      return cstr
    end
  end
  return vim.bo.commentstring
end

require("Comment").setup({ mappings = false, pre_hook = pre_hook })
