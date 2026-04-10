local nightasty = require("monokai-nightasty")

local opts = {
   dark_style_background = "#1B1D1E",
   on_highlights = function (highlights, _)
      highlights["@attribute.builtin"].italic = false
      highlights["@constructor"].italic = false
      highlights["@keyword"].italic = false
      highlights["@keyword.function"].italic = false
      highlights["@markup.quote"].italic = false
      highlights["@tag.attribute"].italic = false
      highlights["@variable.builtin"].italic = false
      highlights["@variable.member"].italic = false
      highlights["@variable.parameter"].italic = false
      highlights["MatchParen"].underline = false
   end,
   cache = true,
   auto_enable_plugins = false,
   plugins = {
      ["bufferline.nvim"] = true,
      ["gitsigns.nvim"] = true,
      ["indent-blankline.nvim"] = true,
      ["lualine"] = true,
      ["noice"] = false,
      ["nvim-cmp"] = true,
      ["telescope.nvim"] = true,
      ["vim-sneak"] = true,
      all = true,
   },
}

nightasty.setup(opts)
nightasty.load()
