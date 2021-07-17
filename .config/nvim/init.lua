local execute = vim.api.nvim_command
local cmd = vim.cmd
local fn = vim.fn

local fmt = string.format

-- Source legacy init.vim
cmd(fmt("source %s/legacy_init.vim", fn.stdpath("config")))

-- Bootstrap packer
local install_path = fmt("%s/site/pack/packer/start/packer.nvim", fn.stdpath("data"))
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute("packadd packer.nvim")
end
