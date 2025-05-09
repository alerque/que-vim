vim.g.augment_disable_tab_mapping = true

vim.keymap.set("i", "<C-l>", "<Cmd>:call augment#Accept()<Cr>", {
   noremap = true,
   silent = true,
})

vim.g.augment_workspace_folders = {
   "~/projects/decasify",
   "~/projects/git-warp-time",
   "~/projects/sile-typesetter/casile",
   "~/projects/sile-typesetter/sile",
}
