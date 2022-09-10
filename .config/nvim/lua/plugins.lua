return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }

  use { "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        default = true
      }
    end
  }

  -- required by telescope
  use { "nvim-lua/plenary.nvim" }

  use { "nvim-telescope/telescope-fzy-native.nvim" }
  use { "nvim-lua/telescope.nvim",
    branch = "0.1.x",
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
        })
      }
      telescope.load_extension("fzy_native")
      vim.keymap.set("n", "!!", builtin.builtin, { noremap = true })
      vim.keymap.set("n", "!b", builtin.buffers, { noremap = true })
      vim.keymap.set("n", "!c", builtin.commands, { noremap = true })
      vim.keymap.set("n", "!f", builtin.find_files, { noremap = true })
      vim.keymap.set("n", "!F", builtin.git_files, { noremap = true })
      vim.keymap.set("n", "!g", builtin.live_grep, { noremap = true })
      vim.keymap.set("v", "!g", builtin.grep_string, { noremap = true })
      vim.keymap.set("n", "!h", builtin.command_history, { noremap = true })
      vim.keymap.set("n", "!m", builtin.marks, { noremap = true })
      vim.keymap.set("n", "!s", builtin.search_history, { noremap = true })
      vim.keymap.set("n", "!t", builtin.tags, { noremap = true })
      vim.keymap.set("n", "!p", builtin.registers, { noremap = true })
      vim.keymap.set("n", "!q", builtin.quickfix, { noremap = true })
      vim.keymap.set("n", "!z", builtin.spell_suggest, { noremap = true })
      vim.keymap.set("v", "!z", builtin.spell_suggest, { noremap = true })
    end
  }

  use { "tpope/vim-repeat" }
  use { "tpope/vim-sensible" }
  use { "tpope/vim-eunuch" }
  use { "tpope/vim-tbone" }
  use { "tpope/vim-unimpaired" }
  use { "tpope/vim-abolish" }
  use { "tpope/vim-speeddating" }
  use { "tpope/vim-characterize" }
  use { "tpope/vim-endwise" }
  use { "tpope/vim-fugitive" }
  use { "tpope/vim-rhubarb" }
  -- Forked from tpope to work with vim-textobj-quote
  use { "alerque/vim-surround" }

  use { "rbong/vim-buffest" }

  use { "nvim-treesitter/nvim-treesitter",
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup {
        highlight = {
          enabled = true,
        },
      }
    end
  }

  use { "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(_, bufnr)
        vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
        vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, opts)
        vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
      local servers = { 'rust_analyzer', 'pyright', 'sumneko_lua' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end
      lspconfig.sumneko_lua.setup {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            -- path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim', 'SILE', 'CASILE', 'pl', 'luautf8' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          }
        }
      }
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')
      vim.o.completeopt = 'menuone,noselect'
    end
  }

  use {
    "NvChad/nvim-colorizer.lua",
    config = function ()
      vim.o.termguicolors = true
      require("colorizer").setup {
        filetypes = {
          "*",
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

  use { "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      cmp.setup {
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }
        },
        sources = {
          { name = "buffer" },
          { name = "calc" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "treesitter" },
        }
      }
    end
  }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-calc" }
  use { "hrsh7th/cmp-nvim-lsp" }

  use { "github/copilot.vim",
    config = function ()
      vim.g.copilot_no_tab_map = true
      vim.g.coppilot_filetypes = {
        ledger = false
      }
      vim.keymap.set("i", "<C-Right>", "copilot#Accept()", { noremap = true, silent = true, expr = true })
    end
  }

end)

