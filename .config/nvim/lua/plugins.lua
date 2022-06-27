return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }

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

  use { "nvim-treesitter/nvim-treesitter" }
  use { "neovim/nvim-lspconfig" }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      vim.o.termguicolors = true
      require("colorizer").setup {
        "*",
        "!vim-plug",
        "!gitcommit",
        css = {
          rgb_fn = true,
          hsl_fn = true,
          css_fn = true
        }
      }
    end
  }

  use { "github/copilot.vim" }

end)

