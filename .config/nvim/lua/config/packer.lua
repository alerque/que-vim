local ensure_packer = function ()
   local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
   if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
      vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
      vim.cmd([[packadd packer.nvim]])
      return true
   end
   return false
end
local packer_bootstrap = ensure_packer()

require("plugins.packer")

if packer_bootstrap then
   require("packer").sync()
end

vim.api.nvim_create_autocmd("BufWritePost", {
   pattern = { "*/plugins/packer.lua" },
   callback = function (event)
      vim.cmd(("source %s"):format(event.file))
      vim.cmd([[PackerSync]])
   end,
})
