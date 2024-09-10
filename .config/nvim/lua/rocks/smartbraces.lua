-- Configure smartbrace key so it doesn't clobber vim default
-- See https://github.com/Konfekt/vim-smartbraces/issues/4
local map = function (keys, tag)
   vim.keymap.set({ "n", "x", "o" }, keys, ([[<Plug>(smartbraces-%s)]]):format(tag))
end

map("g{", "OpenBrace")
map("g}", "CloseBrace")
