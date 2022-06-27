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

  use { "norcalli/nvim-colorizer.lua" }

  use { "github/copilot.vim" }

end)

