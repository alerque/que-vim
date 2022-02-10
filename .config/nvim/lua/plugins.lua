return require("packer").startup(function()
  use("wbthomason/packer.nvim")

  use("tpope/vim-repeat")
  use("tpope/vim-sensible")
  use("tpope/vim-eunuch")
  use("tpope/vim-tbone")
  use("tpope/vim-unimpaired")
  use("tpope/vim-abolish")
  use("tpope/vim-speeddating")
  use("tpope/vim-characterize")
  use("tpope/vim-endwise")
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")

  use("alerque/vim-surround") -- Forked from tpope to work with vim-textobj-quote

  use("norcalli/nvim-colorizer.lua")
end)
