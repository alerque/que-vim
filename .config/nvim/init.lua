local cmd = vim.cmd
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local o = vim.o
local opt = vim.opt

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

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Setup UI preferences
g.mapleader = ","
g.maplocalleader = ","
o.mouse = "a"

o.errorbells = false
o.visualbell = true

o.termguicolors = true

o.colorcolumn = "+1" -- match o.textwidth

-- Default indent style when no filetype specific style guide is in place
o.tabstop = 4
o.shiftwidth = 4
o.shiftround = true
o.expandtab = false
o.cindent = true
o.autoindent = true

-- Add some UTF8 character pairs that should match
-- See also vim-unimpaired in plugins
opt.matchpairs:append{ "�:�" }
opt.matchpairs:append{ "«:»" }
opt.matchpairs:append{ "‹:›" }
opt.matchpairs:append{ "►:◄" }

-- Highlight matching brackets
-- See also vim-matchup in plugins
o.showmatch = true

g.neovide_remember_window_size = false
g.neovide_refresh_rate = 60

local nosi = { noremap = true, silent = true }

local function resize_guifont (delta)
  local guifont = vim.split(o.guifont, ":h")
  local face, size = guifont[1], tonumber(guifont[2])
  size = size + delta
  o.guifont = ("%s:h%s"):format(face, size)
end

map({'n', 'i'}, "<C-+>", function() resize_guifont(1)  end, nosi)
map({'n', 'i'}, "<C-->", function() resize_guifont(-1) end, nosi)

-- Unset F option from campatability mode so we can use Alt keys in keymaps
opt.cpoptions:remove("F")

-- Alternate insert mode with Turkish-F keyboard emulation (from Programer's Dvorak)
-- See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
-- See: http://vi.stackexchange.com/q/2260/267
local km = function (keymap)
  opt.keymap = keymap
  o.iminsert = 1
end
o.imsearch = -1
opt.keymap = "dvp2ptf"
o.iminsert = 0
map({'i', 'c'}, "<A-e>", function() km(nil) end, nosi)
map({'i', 'c'}, "<A-u>", function() km("dvp2ptf") end, nosi)
map({'i', 'c'}, "<A-i>", function() km("dvp2jcu") end, nosi)

-- Source legacy init.vim
cmd(fmt("source %s/legacy_init.vim", fn.stdpath("config")))

-- Bootstrap packer
local install_path = fmt("%s/site/pack/packer/start/packer.nvim", fn.stdpath("data"))
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute("packadd packer.nvim")
end

local plugins = require("plugins")

map({'n', 'i'}, "<Leader>a", vim.lsp.buf.code_action, nosi)

-- Alternative pastes from visual mode
-- See also ReplaceWithRegister plugin
map("x", "<Leader>p", [["_dP]]) -- don't clobber unnamed register
map("x", "<Leader>P", [["0p]]) -- when you did clobber unnamed register

-- Delete without using unnamed buffer
map({"n", "x"}, "<leader>x", [["_x]])

-- Use system clipboard for anonymous register
opt.clipboard:append("unnamedplus")

cmd("autocmd BufWritePost plugins.lua source <afile> | PackerSync")
