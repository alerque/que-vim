local cmd = vim.cmd
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local o = vim.o

local fmt = string.format

local rtp = vim.split(package.path, ';')

-- Group some filetypes for use in selectively loading plugins
g.markdown_filetypes = {
  "markdown",
  "mkd",
  "pandoc",
}

_prose = {
  "asciidoc",
  "mail",
  "org",
  "rst",
  "sile",
  "tex",
  "text",
  "usfm",
}
for _, v in ipairs(g.markdown_filetypes) do
  _prose[#_prose+1] = v
end
g.prose_filetypes = _prose

g.markdown_embeded = {
  'bash=sh',
  'css',
  'html',
  'latex=tex',
  'lua',
  'python',
  'rust',
}

-- Stop vim-polyglot from loading for
-- - CSV, which makes a useless power grab for TSV and sets useless conceals
-- - TeX, using vimtex instead
-- - Lua, loading full plugin directly for freshness
-- - Rust, loading full plugin directly for freshness
g.polyglot_disabled = {
  'csv',
  'latex',
  'lua',
  'rust',
}

-- Source legacy init.vim
cmd(fmt("source %s/legacy_init.vim", fn.stdpath("config")))

-- Bootstrap packer
local install_path = fmt("%s/site/pack/packer/start/packer.nvim", fn.stdpath("data"))
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute("packadd packer.nvim")
end

local plugins = require("plugins")

cmd("autocmd BufWritePost plugins.lua source <afile> | PackerSync")
