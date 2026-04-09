vim.opt.background = "dark"
vim.opt.termguicolors = true

local opts = {
   dark_style_background = "#1B1D1E",
   on_highlights = function (hl, _)
      hl["@attribute.builtin"].italic = false
      hl["@constructor"].italic = false
      hl["@keyword"].italic = false
      hl["@keyword.function"].italic = false
      hl["@markup.quote"].italic = false
      hl["@tag.attribute"].italic = false
      hl["@variable.builtin"].italic = false
      hl["@variable.member"].italic = false
      hl["@variable.parameter"].italic = false
      hl["MatchParen"].underline = false
   end,
   cache = true,
   auto_enable_plugins = false,
   plugins = {
      ["bufferline.nvim"] = true,
      ["gitsigns.nvim"] = true,
      ["indent-blankline.nvim"] = true,
      ["lualine"] = false,
      ["noice"] = false,
      ["nvim-cmp"] = true,
      ["telescope.nvim"] = true,
      ["vim-sneak"] = true,
      all = true,
   },
}

require("monokai-nightasty").setup(opts)
require("monokai-nightasty").load()
