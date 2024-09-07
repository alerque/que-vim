local cmd = vim.cmd
local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

local fmt = string.format

local rtp = vim.split(package.path, ";")

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
   _prose[#_prose + 1] = v
end
g.prose_filetypes = _prose

g.markdown_embeded = {
   "bash=sh",
   "css",
   "html",
   "latex=tex",
   "lua",
   "python",
   "rust",
}

-- Stop vim-polyglot from loading for
-- - CSV, which makes a useless power grab for TSV and sets useless conceals
-- - TeX, using vimtex instead
-- - Lua, loading full plugin directly for freshness
-- - Rust, loading full plugin directly for freshness
g.polyglot_disabled = {
   "csv",
   "latex",
   "lua",
   "rust",
}

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Setup UI preferences
g.mapleader = ","
g.maplocalleader = ","
opt.mouse = "a"

opt.errorbells = false
opt.visualbell = true
vim.api.nvim_create_autocmd("GUIEnter", {
   callback = function ()
      opt.visualbell = true
   end,
})

opt.termguicolors = true
opt.laststatus = 3

opt.colorcolumn = "+1" -- match opt.textwidth

opt.spell = false

-- Default indent style when no filetype specific style guide is in place
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = false
opt.cindent = true
opt.autoindent = true

-- Add some UTF8 character pairs that should match
-- See also vim-unimpaired in plugins
opt.matchpairs:append({ "�:�" })
opt.matchpairs:append({ "«:»" })
opt.matchpairs:append({ "‹:›" })
opt.matchpairs:append({ "►:◄" })

-- Highlight matching brackets
-- See also vim-matchup in plugins
opt.showmatch = true

g.neovide_remember_window_size = false
g.neovide_refresh_rate = 60

local nosi = { noremap = true, silent = true }

local function resize_guifont (delta)
   local guifont = vim.split(vim.o.guifont, ":h")
   local face, size = guifont[1], tonumber(guifont[2])
   size = size + delta
   opt.guifont = ("%s:h%s"):format(face, size)
end

map({ "n", "i" }, "<C-+>", function ()
   resize_guifont(1)
end, nosi)
map({ "n", "i" }, "<C-->", function ()
   resize_guifont(-1)
end, nosi)

map({ "n" }, "<Leader>bo", function ()
   vim.cmd([[%bd|e#|bd#]])
end)

-- Unset F option from campatability mode so we can use Alt keys in keymaps
opt.cpoptions:remove("F")

-- Alternate insert mode with Turkish-F keyboard emulation (from Programer's Dvorak)
-- See: http://vim.wikia.com/wiki/Insert-mode_only_Caps_Lock
-- See: http://vi.stackexchange.com/q/2260/267
local km = function (keymap)
   -- Unsetting this in newer NeoVIM requires more than nil
   opt.keymap = keymap and keymap or ""
   opt.iminsert = 1
end
opt.imsearch = -1
opt.keymap = "dvp2ptf"
opt.iminsert = 0
map({ "i", "c" }, "<A-e>", function ()
   km(nil)
end, nosi)
map({ "i", "c" }, "<A-u>", function ()
   km("dvp2ptf")
end, nosi)
map({ "i", "c" }, "<A-i>", function ()
   km("dvp2jcu")
end, nosi)

-- Don't wrap long lines by default (override for prose file types & Goyo mode)
opt.wrap = false

-- Source legacy init.vim
cmd(fmt("source %s/legacy_init.vim", fn.stdpath("config")))

-- Bootstrap packer
require("config.packer")

-- Bootstrap lazy.nvim
require("config.lazy")

-- Bootstrap rocks.nvim
require("config.rocks")

map({ "n", "i" }, "<Leader>a", vim.lsp.buf.code_action, nosi)

-- Alternative pastes from visual mode
-- See also ReplaceWithRegister plugin
map("x", "<Leader>p", [["_dP]]) -- don't clobber unnamed register
map("x", "<Leader>P", [["0p]]) -- when you did clobber unnamed register

-- Delete without using unnamed buffer
map({ "n", "x" }, "<leader>x", [["_x]])

-- Adapt nerdcommenter muscle memory to NeoVIM 0.10 built in tooling
map({ "n" }, "-", [[1gcc]], { remap = true })
map({ "v" }, "-", [[gc]], { remap = true })

-- Use system clipboard for anonymous register
opt.clipboard:append("unnamedplus")

vim.api.nvim_create_autocmd("BufWritePost", {
   pattern = { "init.lua" },
   callback = function (event)
      vim.cmd(("source %s"):format(event.file))
   end,
})
