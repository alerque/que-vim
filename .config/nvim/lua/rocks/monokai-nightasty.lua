local nightasty = require("monokai-nightasty")

local opts = {
   dark_style_background = "#0f0f0e",
   on_highlights = function (highlights, colors)
      highlights["CursorColumn"].bg = colors.bg_dark
      highlights["IblIndent"].fg = colors.magenta
      highlights["IblScope"].fg = colors.cyan
      highlights["IblWhitespace"].fg = colors.yellow
      highlights["IblIndent"].bg = colors.red
      highlights["IblScope"].fg = colors.green
      highlights["IblWhitespace"].bg = colors.blue
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
