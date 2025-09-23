local function my_plugins (use)
   use("wbthomason/packer.nvim")

   use({
      "vim-syntastic/syntastic",
      setup = function ()
         vim.g.syntastic_check_on_open = 0
         vim.g.syntastic_check_on_wq = 0
         vim.g.syntastic_aggregate_errors = 1
         vim.g.syntastic_error_symbol = "✗"
         vim.g.syntastic_warning_symbol = "⚠"
         vim.g.syntastic_ignore_files =
            { "^/usr/", "*node_modules*", "*vendor*", "*build*", "*LOCAL*", "*BASE", "*REMOTE*" }
         vim.g.syntastic_quiet_messages = { level = "[]", file = { "*_LOCAL_*", "*_BASE_*", "*_REMOTE_*" } }
      end,
   })

   -- "Plug 'jcf/vim-latex'
   -- "Plug 'git://git.code.sf.net/p/atp-vim/code'

   use({
      "christoomey/vim-tmux-navigator",
      setup = function ()
         vim.g.tmux_navigator_no_mappings = 1
      end,
      config = function ()
         -- use alt instead of control to match my tmux
         local function map (l, r)
            vim.keymap.set({ "n", "c" }, l, function ()
               vim.cmd(r)
            end, { noremap = true, silent = true })
         end
         map("<A-h>", "TmuxNavigateLeft")
         map("<A-l>", "TmuxNavigateRight")
         map("<A-j>", "TmuxNavigateDown")
         map("<A-k>", "TmuxNavigateUp")
         map("<A-w>", "TmuxNavigateLeft")
      end,
   })

   use({
      "justinmk/vim-sneak",
      setup = function ()
         vim.g["sneak#label"] = 1
         vim.g["sneak#use_ic_scs"] = 1
         vim.g["sneak#target_labels"] = "aoeuiypqjkxsnthdfgcrlbmwvzAOEUIYPQJKXSNTHDFGCRLBMWVZ"
      end,
   })

   use({
      "sheerun/vim-polyglot",
      setup = function ()
         vim.g.polyglot_disabled = { "lua" }
      end,
   })

   use({
      "tbastos/vim-lua",
      ft = { "lua" },
   })

   use({
      "junegunn/goyo.vim",
      setup = function ()
         vim.g.goyo_width = "90%"
         -- vim.g.goyo_height = "100%"
         vim.g.goyo_margin_top = 2
         vim.g.goyo_margin_bottom = 2
      end,
      config = function ()
         vim.keymap.set("n", "<Leader>r", function ()
            vim.cmd([[Goyo]])
         end, { noremap = true, silent = true })
         vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoEnter",
            nested = true,
            callback = function ()
               vim.cmd([[silent !tmux set status off]])
               vim.cmd([[silent !tmux resize-pane -Z]])
               vim.opt.showmode = false
               vim.opt.showcmd = false
               vim.opt.wrap = true
               vim.opt.list = false
               vim.opt.scrolloff = 999
            end,
         })
         vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoLeave",
            nested = true,
            callback = function ()
               vim.cmd([[silent !tmux set status on]])
               vim.cmd([[silent !tmux resize-pane -Z]])
               vim.opt.showmode = true
               vim.opt.showcmd = true
               vim.opt.wrap = false
               vim.opt.list = true
               vim.opt.scrolloff = 2
            end,
         })
      end,
   })

   use({
      "junegunn/limelight.vim",
      setup = function ()
         -- extra color focus settings to integrate with distraction free mode
         vim.g.limelight_default_coefficient = 0.6
         vim.g.limelight_priority = -1
         -- vim.g.limelight_paragraph_span = 1
      end,
      config = function ()
         vim.keymap.set({ "n", "x" }, "<Leader>l", function ()
            vim.cmd([[Limelight!!]])
         end)
         vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoEnter",
            callback = function ()
               vim.cmd([[Limelight]])
            end,
         })
         vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoLeave",
            callback = function ()
               vim.cmd([[Limelight!]])
            end,
         })
      end,
   })

   use({
      "kyazdani42/nvim-web-devicons",
      config = function ()
         require("nvim-web-devicons").setup({
            default = true,
         })
      end,
   })

   -- required by telescope
   use({
      "nvim-lua/telescope.nvim",
      requires = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope-fzy-native.nvim",
         "nvim-telescope/telescope-project.nvim",
         "nvim-telescope/telescope-ui-select.nvim",
         "tiagovla/scope.nvim",
         "debugloop/telescope-undo.nvim",
         -- "nvim-neorg/neorg-telescope",
      },
      config = function ()
         local telescope = require("telescope")
         local builtin = require("telescope.builtin")
         local theme = require("telescope.themes").get_ivy({})
         local project_actions = require("telescope._extensions.project.actions")
         telescope.setup({
            defaults = vim.tbl_deep_extend("force", theme, {
               mappings = {
                  i = {
                     ["<C-?>"] = "which_key",
                     ["<C-h>"] = "select_horizontal",
                  },
               },
            }),
            extensions = {
               project = {
                  base_dirs = {
                     { "~/projects", maxdepth = 2 },
                     { "~/projects/ipk/ceviriler", maxdepth = 1 },
                     { "~/projects/ipk/siteler", maxdepth = 1 },
                  },
                  on_project_selected = function (prompt_bufnr)
                     project_actions.change_working_directory(prompt_bufnr, false)
                     builtin.git_files()
                  end,
               },
               undo = {},
            },
            ["ui-select"] = {
               -- require("telescope.themes").get_dropdown { }
            },
         })
         telescope.load_extension("fzy_native")
         telescope.load_extension("project")
         telescope.load_extension("ui-select")
         telescope.load_extension("scope")
         telescope.load_extension("undo")
         local map = function (mode, l, r)
            vim.keymap.set(mode, l, r, { noremap = true, silent = true })
         end
         map("n", "!!", builtin.builtin)
         map("n", "!F", builtin.find_files)
         map("n", "!b", telescope.extensions.scope.buffers)
         map("n", "!c", builtin.commands)
         map("n", "!d", builtin.diagnostics)
         map("n", "!f", builtin.git_files)
         map("n", "!g", builtin.live_grep)
         map("n", "!h", builtin.command_history)
         map("n", "!k", builtin.keymaps)
         map("n", "!l", builtin.loclist)
         map("n", "!m", builtin.marks)
         map("n", "!p", telescope.extensions.project.project)
         map("n", "!q", builtin.quickfix)
         map("n", "!r", builtin.registers)
         map("n", "!s", builtin.search_history)
         map("n", "!t", builtin.tags)
         map("n", "!u", telescope.extensions.undo.undo)
         map("n", "!z", builtin.spell_suggest)
         map("v", "!g", builtin.grep_string)
         map("v", "!z", builtin.spell_suggest)
      end,
   })

   use({
      disable = true,
      "folke/noice.nvim",
      event = "VimEnter",
      config = function ()
         if not vim.g.started_by_firenvim then
            require("noice").setup()
         end
      end,
      requires = {
         "MunifTanjim/nui.nvim",
         "rcarriga/nvim-notify",
      },
   })

   use({
      "nvim-lualine/lualine.nvim",
      requires = {
         "nvim-tree/nvim-web-devicons",
         opt = true,
      },
      config = function ()
         local lualine = require("lualine")
         local function macro ()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
               return ""
            else
               return "Recording @" .. recording_register
            end
         end
         vim.api.nvim_create_autocmd("RecordingEnter", {
            callback = function ()
               lualine.refresh({
                  place = { "statusline" },
               })
            end,
         })
         vim.api.nvim_create_autocmd("RecordingLeave", {
            callback = function ()
               local timer = vim.loop.new_timer()
               timer:start(
                  50,
                  0,
                  vim.schedule_wrap(function ()
                     lualine.refresh({
                        place = { "statusline" },
                     })
                  end)
               )
            end,
         })
         lualine.setup({
            options = { theme = "molokai" },
            sections = {
               lualine_a = {
                  "mode",
                  -- function ()
                  --   if not vim.b.pencil_wrap_mode then return "offpops" end
                  --   return vim.api.nvim_command_output("PencilMode") or "notme"
                  -- end,
                  macro,
                  function ()
                     return vim.g.auto_save ~= 0 and "󰸧" or ""
                  end, -- "%{g:auto_save == 1}"
               },
            },
         })
      end,
   })

   use({
      "akinsho/bufferline.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function ()
         vim.opt.termguicolors = true
         require("bufferline").setup({
            options = {
               separator_style = "slant",
               show_close_icon = false,
               show_buffer_close_icons = false,
            },
         })
      end,
   })

   use({
      "tiagovla/scope.nvim",
      config = function ()
         require("scope").setup({})
      end,
   })

   use("tpope/vim-repeat")

   use("tpope/vim-sensible")

   use("tpope/vim-eunuch")

   use("tpope/vim-tbone")

   use("tpope/vim-unimpaired")

   use({
      "andymass/vim-matchup",
      config = function ()
         vim.g.matchup_matchparen_deferred = true
         vim.g.matchup_matchparen_hi_surround_always = true
      end,
   })

   use("tpope/vim-abolish")

   use({
      "tpope/vim-speeddating",
      lazy = false,
      config = function ()
         vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function ()
               vim.cmd([[SpeedDatingFormat %Y%m%d]])
            end,
         })
      end,
   })

   use("tpope/vim-characterize")

   use("tpope/vim-endwise")

   use("tpope/vim-sleuth")

   use({
      "tpope/vim-fugitive",
      config = function ()
         local map = function (mode, l, r)
            vim.keymap.set(mode, l, r, { noremap = true, silent = true })
         end
         map("n", "<leader>gb", ":Git blame<CR>")
         map("n", "<leader>gc", ":Git commit<CR>")
         map("n", "<leader>gl", ":Git log<CR>")
         map("n", "<leader>gw", ":Gwrite<CR>")
         map("n", "<leader>gs", ":Git status!<CR>")
         map("n", "<leader>gd", ":Gvdiffsplit!<CR>")
      end,
   })

   use("tpope/vim-rhubarb")

   -- Forked from tpope to work with vim-textobj-quote
   use("alerque/vim-surround")

   use("rbong/vim-buffest")

   use({
      "shumphrey/fugitive-gitlab.vim",
      after = "vim-fugitive",
      config = function ()
         vim.g.fugitive_gitlab_domains = { "https://gitlab.com", "https://gitlab.alerque.com" }
         vim.g.fugitive_gitlab_ssh_user = "gitlab"
      end,
   })

   use({ "tommcdo/vim-fugitive-blame-ext", after = "vim-fugitive" })

   use({
      "gcmt/wildfire.vim",
      config = function ()
         vim.g.wildfire_objects = {
            "i'",
            'i"',
            "iq",
            "aq",
            "iQ",
            "aQ",
            "i)",
            "i }",
            "i}",
            "i<",
            "if",
            "af",
            "it",
            "at",
            "ip",
            "ae",
         }
      end,
   })

   use({
      "lukas-reineke/indent-blankline.nvim",
      config = function ()
         vim.opt.termguicolors = true
         local highlight = {
            "CursorColumn",
            "Whitespace",
         }
         require("ibl").setup({
            exclude = {
               buftypes = { "terminal" },
               filetypes = { "help", "packer" },
            },
            indent = {
               highlight = highlight,
               char = "",
            },
            whitespace = {
               highlight = highlight,
               remove_blankline_trail = false,
            },
            scope = {
               enabled = false,
            },
         })
      end,
   })

   use({
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      config = function ()
         local treesitter = require("nvim-treesitter")
         treesitter.setup({
            -- Use syntax highlighting from vim-just over treesitter implementation
            highlight = {
               enable = true,
               disable = { "just" },
            },
         })
      end,
   })

   use({
      "hrsh7th/nvim-cmp",
      requires = {
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-nvim-lsp",
         "ray-x/cmp-treesitter",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-calc",
         "hrsh7th/cmp-omni",
         "uga-rosa/cmp-dictionary",
         -- "f3fora/cmp-spell",
      },
      config = function ()
         local cmp = require("cmp")
         cmp.setup({
            mapping = {
               ["<C-p>"] = cmp.mapping.select_prev_item(),
               ["<C-n>"] = cmp.mapping.select_next_item(),
               ["<C-d>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-e>"] = cmp.mapping.close(),
               -- ["<Tab>"] = cmp.mapping.complete(),
               ["<Tab>"] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
               }),
            },
            sources = {
               -- { name = "emoji" }
               { name = "path" },
               -- { name = "spell" },
               -- { name = "tags" },
               { name = "nvim_lua" },
               { name = "nvim_lsp" },
               { name = "treesitter" },
               { name = "path" },
               { name = "buffer" },
               { name = "dictionary" },
               { name = "calc" },
               { name = "codeium" },
               -- { name = "neorg" },
            },
         })
      end,
   })

   use({
      "neovim/nvim-lspconfig",
      requires = "hrsh7th/cmp-nvim-lsp",
      config = function ()
         local on_attach = function (_, buffnr)
            -- vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
            local map = function (mode, l, r)
               vim.keymap.set(mode, l, r, { noremap = true, silent = true, buffer = buffnr })
            end
            map("n", "gD", vim.lsp.buf.declaration)
            map("n", "gd", vim.lsp.buf.definition)
            -- map('n', 'K', vim.lsp.buf.hover)
            map("n", "<C-k>", vim.lsp.buf.signature_help)
            map("n", "gi", vim.lsp.buf.implementation)
            map("n", "<leader>gt", vim.lsp.buf.type_definition)
            -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
            -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
            -- map('n', '<leader>wl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
            map("n", "<leader>rn", vim.lsp.buf.rename)
            map("n", "gr", vim.lsp.buf.references)
            map("n", "<leader>ca", vim.lsp.buf.code_action)
            -- map('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics)
            -- map('n', '<leader>q', vim.lsp.diagnostic.set_loclist)
            map("n", "<leader>so", require("telescope.builtin").lsp_document_symbols)
            vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
         end
         vim.lsp.config("*", {
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            root_markers = { ".git" },
         })
         -- See lsp/*.lua for per-server config overrides
         vim.lsp.enable({
            "clangd",
            -- "dockerls",
            "just",
            "lua_ls",
            "marksman",
            "pyright",
            "ruff",
            "rust_analyzer",
            "stylua",
            "taplo",
         })
         vim.opt.completeopt = { "menuone", "noselect" }
      end,
   })

   use({
      "Exafunction/codeium.nvim",
      disable = true,
      requires = {
         "nvim-lua/plenary.nvim",
         "hrsh7th/nvim-cmp",
      },
      config = function ()
         require("codeium").setup({})
      end,
   })

   use({
      "tanvirtin/monokai.nvim",
      config = function ()
         local monokai = require("monokai")
         local moloque = monokai.classic
         moloque.name = "moloque"
         moloque.base2 = "#1B1D1E" -- Normal
         moloque.base3 = "#293739" -- CursorColumn
         monokai.setup({
            italics = false,
            palette = moloque,
         })
      end,
   })

   use({
      "nvchad/nvim-colorizer.lua",
      config = function ()
         vim.opt.termguicolors = true
         require("colorizer").setup({
            filetypes = {
               "*",
               "!ledger",
               "!markdown",
               "!pandoc",
               "!vim-plug",
               "!gitcommit",
               css = {
                  rgb_fn = true,
                  hsl_fn = true,
                  css_fn = true,
               },
            },
            user_default_options = {
               mode = "virtualtext",
               virtualtext = "■",
            },
         })
      end,
   })

   use({
      "lewis6991/gitsigns.nvim",
      config = function ()
         vim.opt.signcolumn = "yes"
         require("gitsigns").setup({
            on_attach = function (buffnr)
               local gs = package.loaded.gitsigns
               local map = function (mode, l, r)
                  vim.keymap.set(mode, l, r, { noremap = true, silent = true, buffer = buffnr })
               end
               map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
               map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
               map("n", "]h", gs.next_hunk)
               map("n", "[h", gs.prev_hunk)
               map("n", "<leader>hb", gs.blame_line)
               map("n", "<leader>hd", gs.diffthis)
               map("n", "<leader>hp", gs.preview_hunk)
               map("n", "<leader>hR", gs.reset_buffer)
               map("n", "<leader>hu", gs.undo_stage_hunk)
               map("n", "<leader>htd", gs.toggle_deleted)
               map("n", "<leader>htb", gs.toggle_current_line_blame)
               map("n", "<leader>hth", gs.toggle_linehl)
            end,
            numhl = true,
            word_diff = true,
         })
      end,
   })

   use({
      "glacambre/firenvim",
      run = function ()
         vim.fn["firenvim#install"](0)
      end,
      config = function ()
         local max_height = 60
         local id = vim.api.nvim_create_augroup("ExpandLinesOnTextChanged", { clear = true })
         vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
            group = id,
            callback = function (ev)
               local height = vim.api.nvim_win_text_height(0, {}).all
               height = height + 3
               if height > vim.o.lines and height < max_height then
                  vim.o.lines = height
               end
            end,
         })
         vim.api.nvim_create_autocmd("UIEnter", {
            callback = function ()
               local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
               if client ~= nil and client.name == "Firenvim" then
                  vim.opt.guifont = "Hack Nerd Font:h12"
                  vim.g.syntastic_skip_checks = 1
                  vim.opt.showtabline = 0
                  vim.opt.laststatus = 0
                  vim.opt.wrap = true
                  vim.opt.spell = true
                  vim.opt.spelllang = { "en", "tr" }
                  -- vim.cmd [[Codeium Off]]
                  -- AutoSaveToggle
                  vim.keymap.set("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<Cr>", {})
                  vim.keymap.set("n", "<C-z>", "<Cmd>call firenvim#hide_frame()<Cr>", {})
               end
            end,
         })
         local localSettings = {
            [".*"] = {
               priority = 0,
               cmdline = "neovim",
               selector = 'textarea, div[role="textbox"]',
               takeover = "once",
            },
         }
         local function never (pattern)
            local site = {}
            site.priority = 1
            site.takeover = "never"
            localSettings[pattern] = site
         end
         local function markdown (pattern, ft)
            local site = {}
            site.content = ft or "markdown"
            localSettings[pattern] = site
         end
         never("https://mattermost\\.alerque\\.com")
         never("https://mattermost\\.coko\\.foundation")
         never("https://discord\\.com")
         never("https://app\\.element\\.io")
         never("https://gab\\.com")
         never("https://gitter\\.im")
         never("https://grep\\.app")
         never("https://www\\.google\\.com/search")
         never("https://keep\\.google\\.com")
         never("https://mail\\.google\\.com/mail")
         never("https://console\\.hetzner\\.cloud")
         never("https://www\\.keybr\\.com")
         never("https://mastodon\\.social")
         never("https://mattermost\\.alerque\\.com")
         never("https://mattermost\\.coko\\.foundation")
         never("https://app\\.slack\\.com")
         never("https://.*stackexchange\\.com")
         never("https://.*stackoverflow\\.com")
         never("https://sourcegraph\\.com")
         never("https://tweetdeck\\.twitter\\.com")
         never("https://typo\\.social")
         never("https://twitter\\.com")
         never("https://web\\.whatsapp\\.com")
         never("https://x\\.com")
         markdown("github.com_*.txt")
         markdown("gitlab.com_*.txt")
         markdown("gitlab.alerque.com_*.txt", "pandoc")
         markdown("gitter.im_*.txt")
         localSettings["github.com"] = {
            selector = "textarea:not(#pull_request_review_body)",
         }
         -- set filetype=markdown | nnoremap <leader><Cr> write<Cr>:call firenvim#press_keys("<Lt>CR>")<cR>ggdGa
         vim.g.firenvim_config = {
            globalSettings = {
               --       ignoreKeys = {
               --         all = "<C-Tab>"
               --       },
               --       ["<C-w>"] = "noop",
               --       ["<C-n>"] = "default"
            },
            localSettings = localSettings,
         }
      end,
   })

   use({
      "davidsierradz/cmp-conventionalcommits",
      ft = { "gitcommit" },
      config = function ()
         require("cmp").setup.buffer({
            sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
         })
      end,
   })

   use({
      "ledger/vim-ledger",
      ft = { "ledger" },
      requires = {
         "hrsh7th/nvim-cmp",
         "kirasok/cmp-hledger",
      },
      setup = function ()
         vim.g.ledger_is_hledger = true
         vim.g.ledger_maxwidth = 80
         vim.g.ledger_align_at = 63
         vim.g.ledger_default_commodity = "₺"
         vim.g.ledger_decimal_sep = ".,"
         vim.g.ledger_align_last = true
         vim.g.ledger_detailed_first = 1
         vim.g.ledger_fold_blanks = 1
         vim.g.ledger_bin = "hledger"
         vim.g.ledger_fillstring = "    -"
         vim.g.ledger_extra_options = "-x"
         vim.g.ledger_accounts_generate = 0
         vim.g.ledger_accounts_cmd = "cat _vim_accounts"
         vim.g.ledger_descriptions_cmd = "cat _vim_descriptions"
      end,
      config = function ()
         require("cmp").setup.buffer({
            completion = {
               keyword_length = 2,
               keyword_pattern = [[.*]],
            },
            sources = {
               -- { name = "omni" },
               { name = "hledger" },
               -- { name = "buffer" },
               -- { name = "spell" },
               { name = "calc" },
            },
         })
         local function map (mode, l, r)
            vim.keymap.set(mode, l, r, { noremap = true, buffer = true, silent = true })
         end
         vim.opt.colorcolumn = "60"
         vim.opt_local.expandtab = true
         vim.opt_local.iskeyword:append(":")
         vim.opt_local.formatprg = ("%s -f - print -x"):format(vim.g.ledger_bin)
         -- vim.opt_local.formatexpr = nil
         vim.cmd([[SpeedDatingFormat %Y-%m-%d]])
         local function start_commodity (symbol)
            vim.cmd([[normal! A  ]] .. symbol)
            vim.call("ledger#align_commodity")
            vim.cmd("startinsert!")
         end
         local function backtrack_commodity ()
            local rr = vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true)
            vim.api.nvim_feedkeys(rr, "m", true)
         end
         map("i", "<C-t>", function ()
            start_commodity("₺")
         end)
         map("i", "<C-d>", function ()
            start_commodity("$")
         end)
         map("i", "<C-e>", function ()
            start_commodity("€")
         end)
         map("i", "<C-l>", function ()
            start_commodity("₤")
         end)
         map("i", "<C-k>", function ()
            start_commodity("₸")
            backtrack_commodity()
         end)
         map("i", "<C-b>", function ()
            start_commodity("BTC")
         end)
         -- map("i", "<C-n>", [[<C-r>=ledger#autocomplete_and_align()<Cr>]])
         map({ "i", "n" }, "<Leader>n", [[<Esc>gqipkvip:LedgerAlign<Cr>{yE}pE]])
         map({ "i", "n" }, "<Leader>f", [[vap:'<,'>!./bin/normalize.zsh<Cr>gqap]])
         map({ "i", "n" }, "<Leader>p", function ()
            local formatexpr = vim.o.formatexpr
            vim.o.formatexpr = nil
            vim.cmd([[normal! gqip]])
            vim.o.formatexpr = formatexpr
            vim.cmd([[normal! kgqap]])
         end)
      end,
   })

   use({
      "https://git.sr.ht/~soywod/himalaya-vim",
      disable = true,
      requires = "nvim-lua/telescope.nvim",
      config = function ()
         vim.g.himalaya_folder_picker = "telescope"
      end,
   })

   use({
      "preservim/vimux",
      config = function ()
         vim.g.VimuxOrientation = "h"
         vim.g.VimuxUseNearest = true
         vim.keymap.set("n", "<Leader>p", ":VimuxPromptCommand<Cr>", { noremap = true, silent = true })
      end,
   })

   use({
      "preservim/vim-pencil",
      config = function ()
         vim.g["pencil#wrapModeDefault"] = "soft"
         vim.g["pencil#concealcursor"] = "nc"
         vim.g["pencil#conceallevel"] = false
      end,
   })

   use("preservim/vim-colors-pencil")

   use({
      "preservim/vim-lexical",
      config = function ()
         vim.g["lexical#spell"] = false
      end,
   })

   use("preservim/vim-wordy")

   use("preservim/vim-textobj-sentence")

   use({
      "preservim/vim-textobj-quote",
      config = function ()
         vim.keymap.set({ "n", "i" }, "<leader>E", ":ToggleEducate<CR>", { noremap = true, silent = true })
      end,
   })

   use({
      "uga-rosa/translate.nvim",
      setup = function ()
         local readsecret = function ()
            local home = os.getenv("HOME")
            local secretfile = io.open(home .. "/.private/deepl_api.sh", "r")
            if not secretfile then
               return nil
            end
            local secretsh = secretfile:read("*a")
            secretfile:close()
            return secretsh:match('.*"(.*)"')
         end
         vim.g.deepl_api_auth_key = os.getenv("DEEPL_AUTH_KEY") or readsecret()
      end,
      config = function ()
         require("translate").setup({
            default = {
               command = "deepl_free",
               output = "replace",
            },
            preset = {
               output = {
                  split = {
                     append = true,
                  },
               },
            },
         })
         vim.keymap.set("v", "t", ":Translate TR -source=en<Cr>", { noremap = true, silent = true })
      end,
   })

   use({
      "FooSoft/vim-argwrap",
      config = function ()
         vim.keymap.set("n", "<Leader>w", ":ArgWrap<Cr>", { noremap = true, silent = true })
         vim.api.nvim_create_autocmd("FileType", {
            pattern = "vim",
            callback = function ()
               vim.b.argwrap_line_prefix = "\\ "
            end,
         })
      end,
   })

   use("zhimsel/vim-stay")

   use("preservim/vim-wheel")

   use("preservim/vim-wordchipper")

   use("pangloss/vim-javascript")

   use("sile-typesetter/vim-sile")

   use({ "kaarmu/typst.vim", ft = { "typst" } })

   use("https://gitlab.com/rwx.gg/abnf")

   use("r-bar/ebnf.vim")

   use("projectfluent/fluent.vim")

   use("leafo/moonscript-vim")

   use("egberts/vim-syntax-bind-named")

   use("ekalinin/Dockerfile.vim")

   use("tridactyl/vim-tridactyl")

   use({ "NoahTheDuke/vim-just", ft = { "just" } })

   use({
      "inkarkat/vim-ReplaceWithRegister",
      requires = {
         "inkarkat/vim-ingo-library",
         "inkarkat/vim-visualrepeat",
         "tpope/vim-repeat",
      },
      -- see also alternative register paste maps in init.vim
   })

   use("machakann/vim-highlightedyank")

   use({ "glts/vim-radical", requires = {
      "glts/vim-magnum",
      "tpope/vim-repeat",
   } })

   use("stefandtw/quickfix-reflector.vim")

   use("junegunn/vader.vim")
end

return require("packer").startup({
   my_plugins,
   config = {
      display = { compact = true },
      -- See ~/.cache/nvim/packer.nvim.log
      -- log = { level = "debug" },
      autoremove = true,
   },
})
