local configdir = vim.fn.stdpath("config")

-- Source legacy init.vim
vim.cmd("source " .. configdir .. "/legacy_init.vim")
