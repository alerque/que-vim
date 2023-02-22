return require("packer").startup(function (use)
  use { "wbthomason/packer.nvim" }

  use { "kyazdani42/nvim-web-devicons",
    config = function ()
      require("nvim-web-devicons").setup {
        default = true
      }
    end
  }

  -- required by telescope
  use { "nvim-lua/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function ()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local theme = require("telescope.themes").get_ivy({})
      telescope.setup {
        defaults = vim.tbl_deep_extend("force", theme, {
          mappings = {
            i = {
              ["<C-?>"] = "which_key",
              ["<C-h>"] = "select_horizontal"
            }
          }
        }),
        extensions = {
          project = {
            base_dirs = {
              { "~/projects", maxdepth = 2 }
            }
          }
        },
        ["ui-select"] = {
          -- require("telescope.themes").get_dropdown { }
        }
      }
      telescope.load_extension("fzy_native")
      telescope.load_extension("project")
      telescope.load_extension("ui-select")
      local map = function (mode, l, r)
        vim.keymap.set(mode, l, r, { noremap = true, silent = true })
      end
      map("n", "!!", builtin.builtin)
      map("n", "!b", builtin.buffers)
      map("n", "!c", builtin.commands)
      map("n", "!f", builtin.git_files)
      map("n", "!F", builtin.find_files)
      map("n", "!g", builtin.live_grep)
      map("v", "!g", builtin.grep_string)
      map("n", "!h", builtin.command_history)
      map("n", "!m", builtin.marks)
      map("n", "!s", builtin.search_history)
      map("n", "!t", builtin.tags)
      map("n", "!p", telescope.extensions.project.project)
      map("n", "!q", builtin.quickfix)
      map("n", "!r", builtin.registers)
      map("n", "!z", builtin.spell_suggest)
      map("v", "!z", builtin.spell_suggest)
    end
  }

  use({
    disable = true,
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  use { "tpope/vim-repeat" }

  use { "tpope/vim-sensible" }

  use { "tpope/vim-eunuch" }

  use { "tpope/vim-tbone" }

  use { "tpope/vim-unimpaired" }

  use { "andymass/vim-matchup",
    config = function ()
    vim.g.matchup_matchparen_deferred = true
    vim.g.matchup_matchparen_hi_surround_always = true
    end
  }

  use { "tpope/vim-abolish" }

  use { "tpope/vim-speeddating",
    lazy = false,
    config = function ()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function ()
          vim.cmd [[SpeedDatingFormat %Y%m%d]]
        end
      })
    end
  }

  use { "tpope/vim-characterize" }

  use { "tpope/vim-endwise" }

  use { "tpope/vim-sleuth" }

  use { "tpope/vim-fugitive",
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
    end
  }

  use { "tpope/vim-rhubarb" }

  -- Forked from tpope to work with vim-textobj-quote
  use { "alerque/vim-surround" }

  use { "rbong/vim-buffest" }

  use { "shumphrey/fugitive-gitlab.vim",
    after = "vim-fugitive",
    config = function ()
      vim.g.fugitive_gitlab_domains = { "https://gitlab.com", "https://gitlab.alerque.com" }
      vim.g.fugitive_gitlab_ssh_user = "gitlab"
    end
  }

  use { "tommcdo/vim-fugitive-blame-ext",
    after = "vim-fugitive"
  }

  use { "gcmt/wildfire.vim",
    config = function ()
      vim.g.wildfire_objects = {
        "i'", 'i"', "iq", "aq", "iQ", "aQ", "i)", "i }", "i}", "i<", "if", "af", "it", "at", "ip", "ae"
      }
    end
  }

  use { "lukas-reineke/indent-blankline.nvim",
    config = function ()
      vim.opt.termguicolors = true
      local function hl (group, opts) vim.api.nvim_set_hl(0, group, opts) end
      hl("IndentBlanklineIndent1", { bg = "NONE", nocombine = true })
      hl("IndentBlanklineIndent2", { link = "CursorColumn", nocombine = true })
      require("indent_blankline").setup {
        char = "",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        buftype_exclude = { "terminal" },
        filetype_exclude = { "help", "packer" },
        show_current_context = true,
        show_current_context_start = true,
        show_first_indent_level = false,
        show_trailing_blankline_indent = false,
      }
    end
  }

  use { "nvim-treesitter/nvim-treesitter",
    config = function ()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup {
        highlight = {
          enabled = true,
        },
      }
    end
  }

  use { "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  }

  use { "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    requires = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-omni",
      "uga-rosa/cmp-dictionary",
      "f3fora/cmp-spell",
      "L3MON4D3/LuaSnip",
    },
    config = function ()
      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function (args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),
          -- ["<Tab>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }
        },
        sources = {
          -- { name = "emoji" }
          { name = "path" },
          { name = "spell" },
          -- { name = "tags" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "treesitter" },
          { name = "path" },
          { name = "buffer" },
          { name = "dictionary" },
          { name = "spell" },
          { name = "calc" }
        }
      }
    end
  }

  use { "saadparwaiz1/cmp_luasnip" }

  use { "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function ()
      local lspconfig = require("lspconfig")
      local on_attach = function (_, buffnr)
        -- vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
        local map = function (mode, l, r)
          vim.keymap.set(mode, l, r, { noremap = true, silent = true, buffer = buffnr })
        end
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', '<C-k>', vim.lsp.buf.signature_help)
        map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
        map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
        map('n', '<leader>wl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
        map('n', '<leader>D', vim.lsp.buf.type_definition)
        map('n', '<leader>rn', vim.lsp.buf.rename)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', '<leader>ca', vim.lsp.buf.code_action)
        -- map('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics)
        -- map('n', '[d', vim.lsp.diagnostic.goto_prev)
        -- map('n', ']d', vim.lsp.diagnostic.goto_next)
        -- map('n', '<leader>q', vim.lsp.diagnostic.set_loclist)
        map('n', '<leader>so', require('telescope.builtin').lsp_document_symbols)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
      end
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { 'rust_analyzer', 'pyright', 'lua_ls' }
      local runtime_path = vim.split(package.path, ';')
      -- table.insert(runtime_path, 'lua/?.lua')
      -- table.insert(runtime_path, 'lua/?/init.lua')
      local defaults = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = runtime_path
            },
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            },
            completion = {
              -- callSnippet = "Both",
              displayContext = 2
            },
            hint = {
              enable = true
            },
            telemetry = {
              enable = false
            }
          }
        }
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup(defaults)
      end
      vim.opt.completeopt = { "menuone", "noselect" }
    end
  }

  use { "justinmk/molokai",
    config = function ()
      vim.g.molokai_italic = 0
      vim.cmd [[colorscheme molokai]]
    end
  }

  use { "nvchad/nvim-colorizer.lua",
    config = function ()
      vim.opt.termguicolors = true
      require("colorizer").setup {
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
            css_fn = true
          }
        },
        user_default_options = {
          mode = "virtualtext",
          virtualtext = '■'
        }
      }
    end
  }

  use { "lewis6991/gitsigns.nvim",
    config = function ()
      vim.opt.signcolumn = "yes"
      require("gitsigns").setup {
        on_attach = function (buffnr)
          local gs = package.loaded.gitsigns
          local map = function (mode, l, r)
            vim.keymap.set(mode, l, r, { noremap = true, silent = true, buffer = buffnr })
          end
          map({"n", "v"}, "<leader>hs", gs.stage_hunk)
          map({"n", "v"}, "<leader>hr", gs.reset_hunk)
          map("n", "]c", gs.next_hunk)
          map("n", "[c", gs.prev_hunk)
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
        word_diff = true
      }
    end
  }

  use { "gpanders/editorconfig.nvim",
    config = function ()
      -- Add custom spelling language property
      -- Two options seen in the wild do the same thing
      vim.g.editorconfig_properties = { "locale_language", "spell_language" }
      local ecp = require("editorconfig").properties
      local function spelllang (bufnr, val)
        vim.bo[bufnr].spelllang = val
      end
      ecp.locale_language = spelllang
      ecp.spell_language = spelllang
    end
  }

  use { "ledger/vim-ledger",
    ft = { "ledger" },
    config = function ()
      local cmp = require("cmp")
      cmp.setup.buffer {
        completion = {
          keyword_length = 2,
          keyword_pattern = [[.*]]
        },
        sources = {
          { name = "omni" },
          -- { name = "buffer" },
          -- { name = "spell" },
          { name = "calc" }
        }
      }
      vim.g.ledger_maxwidth = 80
      vim.g.ledger_align_at = 63
      vim.g.ledger_default_commodity = '₺'
      vim.g.ledger_decimal_sep = '.,'
      vim.g.ledger_align_last = true
      vim.g.ledger_detailed_first = 1
      vim.g.ledger_fold_blanks = 1
      vim.g.ledger_bin = "hledger"
      vim.g.ledger_fillstring = '    -'
      vim.g.ledger_extra_options = "-x"
      vim.g.ledger_accounts_generate = 0
      vim.g.ledger_accounts_cmd = "cat _vim_accounts"
      vim.g.ledger_descriptions_cmd = "cat _vim_descriptions"
      local function map (mode, l, r) vim.keymap.set(mode, l, r, { noremap = true, buffer = true, silent = true }) end
      local function autocmd (func) vim.api.nvim_create_autocmd("FileType", { pattern = "ledger", callback = func }) end
      autocmd(function ()
        vim.opt_local.expandtab = true
        vim.opt_local.iskeyword:append(":")
        vim.opt_local.formatprg = ("%s -f - print -x"):format(vim.g.ledger_bin)
        -- vim.opt_local.formatexpr = nil
        vim.cmd [[SpeedDatingFormat %Y-%m-%d]]
        local function start_commodity (symbol)
          vim.cmd([[normal! A  ]] .. symbol)
          vim.call("ledger#align_commodity")
          vim.cmd("startinsert!")
        end
        local function backtrack_commodity ()
          local rr = vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true)
          vim.api.nvim_feedkeys(rr, "m", true)
        end
        map("i", "<C-t>", function () start_commodity("₺") end)
        map("i", "<C-d>", function () start_commodity("$") end)
        map("i", "<C-e>", function () start_commodity("€") end)
        map("i", "<C-l>", function () start_commodity("₤") end)
        map("i", "<C-k>", function () start_commodity("₸"); backtrack_commodity() end)
        map("i", "<C-b>", function () start_commodity("BTC") end)
        map("i", "<C-n>", [[<C-r>=ledger#autocomplete_and_align()<Cr>]])
        map({ "i", "n" }, "<Leader>n", [[<Esc>gqipkvip:LedgerAlign<Cr>{yE}pE]])
        map({ "i", "n" }, "<Leader>f", [[gqap]])
        map({ "i", "n" }, "<Leader>p", function ()
          local formatexpr = vim.o.formatexpr
          vim.o.formatexpr = nil
          vim.cmd [[normal! gqip]]
          vim.o.formatexpr = formatexpr
          vim.cmd [[normal! kgqap]]
        end)
      end)
    end
  }

  use { "https://git.sr.ht/~soywod/himalaya-vim",
    requires = {
      "nvim-lua/telescope.nvim"
    },
    config = function ()
      vim.g.himalaya_folder_picker = "telescope"
    end
  }

  use { "preservim/nerdcommenter",
    config = function ()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCompactSexyComs = 1
      vim.g.NERDDefaultAlign = "left"
      vim.g.NERDAltDelims_c = 1
    end
  }

  use { "preservim/vim-indent-guides",
    config = function ()
      vim.g.indent_guides_enable_on_vim_startup = true
    end
  }

  use { "preservim/vimux",
    config = function ()
      vim.g.VimuxOrientation = "h"
      vim.g.VimuxUseNearest = true
      vim.keymap.set("n", "<Leader>p", ":VimuxPromptCommand<Cr>", { noremap = true, silent = true })
    end
  }

  use { "jtdowney/vimux-cargo",
    requires = {
      "preservim/vimux"
    }
  }

  use { "preservim/vim-pencil",
    config = function ()
      vim.g["pencil#wrapModeDefault"] = "soft"
      vim.g["pencil#concealcursor"] = "nc"
      vim.g["pencil#conceallevel"] = false
    end
  }

  use { "preservim/vim-colors-pencil" }

  use { "preservim/vim-lexical",
    config = function ()
      vim.g["lexical#spell"] = true
    end
  }

  use { "preservim/vim-wordy" }

  use { "preservim/vim-textobj-sentence" }

  use { "preservim/vim-textobj-quote",
    config = function ()
      vim.keymap.set({"n", "i"}, "<leader>e", ":ToggleEducate<CR>", { noremap = true, silent = true })
    end
  }

  use { "FooSoft/vim-argwrap",
    config = function ()
      vim.keymap.set("n", "<Leader>w", ":ArgWrap<Cr>", { noremap = true, silent = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vim",
        callback = function ()
          vim.b.argwrap_line_prefix = "\\ "
        end
      })
    end
  }

  use { "preservim/vim-wheel" }

  use { "preservim/vim-wordchipper" }

  use { "sile-typesetter/vim-sile" }

  use { "https://gitlab.com/rwx.gg/abnf" }

  use { "projectfluent/fluent.vim" }

  use { "leafo/moonscript-vim" }

  use { "egberts/vim-syntax-bind-named" }

  use { "ekalinin/Dockerfile.vim" }

  use { "tridactyl/vim-tridactyl" }

  use { "inkarkat/vim-ReplaceWithRegister",
    requires = {
      "inkarkat/vim-ingo-library",
      "inkarkat/vim-visualrepeat",
      "tpope/vim-repeat"
    },
    -- see also alternative register paste maps in init.vim
  }

  use { "glts/vim-radical",
    requires = {
      "glts/vim-magnum",
      "tpope/vim-repeat"
    }
  }

  use { "stefandtw/quickfix-reflector.vim" }

  use { "junegunn/vader.vim" }

end)
