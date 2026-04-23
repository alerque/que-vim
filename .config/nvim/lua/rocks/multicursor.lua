local mc = require("multicursor-nvim")

mc.setup()

vim.keymap.set({ "n", "x" }, "<C-Up>", function ()
   mc.lineAddCursor(-1)
end, { desc = "Add cursor up" })
vim.keymap.set({ "n", "x" }, "<C-Down>", function ()
   mc.lineAddCursor(1)
end, { desc = "Add cursor down" })
-- vim.keymap.set({ "n", "x" }, "<Leader><Up>", function ()
--    mc.lineSkipCursor(-1)
-- end)
-- vim.keymap.set({ "n", "x" }, "<Leader><Down>", function ()
--    mc.lineSkipCursor(1)
-- end)

vim.keymap.set({ "n", "x" }, "<Leader>n", function ()
   mc.matchAddCursor(1)
end, { desc = "Add cursor at next match of word under cursor" })
vim.keymap.set({ "n", "x" }, "<Leader>s", function ()
   mc.matchSkipCursor(1)
end, { desc = "Skip next match without adding cursor" })
vim.keymap.set({ "n", "x" }, "<Leader>N", function ()
   mc.matchAddCursor(-1)
end, { desc = "Add cursor at next match of word under cursor" })
vim.keymap.set({ "n", "x" }, "<Leader>S", function ()
   mc.matchSkipCursor(-1)
end, { desc = "Skip previous match without adding cursor" })

vim.keymap.set("n", "<C-LeftMouse>", mc.handleMouse)
vim.keymap.set("n", "<C-LeftDrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<C-LeftRelease>", mc.handleMouseRelease)

-- vim.keymap.set({ "n", "x" }, "<C-q>", mc.toggleAllCursors, { desc = "Toggle multi-cursor mode" })
vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Deactivate link to current cursor" })

mc.addKeymapLayer(function (layerSet)
   layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
   layerSet({ "n", "x" }, "<Right>", mc.nextCursor)
   layerSet({ "n", "x" }, "<Leader>x", mc.deleteCursor)
   layerSet("n", "<Esc>", function ()
      if not mc.cursorsEnabled() then
         mc.enableCursors()
      else
         mc.clearCursors()
      end
   end)
end)
