vim.g.asterisk_keeppos = 1

vim.keymap.set({ "n", "x", "o" }, "*", "<Plug>(asterisk-z*)")
vim.keymap.set({ "n", "x", "o" }, "#", "<Plug>(asterisk-z#)")
vim.keymap.set({ "n", "x", "o" }, "g*", "<Plug>(asterisk-gz*)")
vim.keymap.set({ "n", "x", "o" }, "g#", "<Plug>(asterisk-gz#)")
