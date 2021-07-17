local cmd = vim.cmd
local fn = vim.fn

local fmt = string.format

-- Source legacy init.vim
cmd(fmt("source %s/legacy_init.vim", fn.stdpath("config")))
