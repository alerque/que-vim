return {
   commands = {
      Format = {
         function ()
            require("stylua-nvim").format_file()
         end,
      },
   },
   on_init = function (client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
         return
      end
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings, {
         runtime = {
            version = "LuaJIT",
         },
         workspace = {
            didChangeWatchedFiles = {
               dynamicRegistration = true,
            },
            checkThirdParty = false,
            library = vim.env.VIMRUNTIME,
         },
      })
      return true
   end,
   settings = {
      Lua = {
         completion = {
            displayContext = 2,
         },
         hint = {
            enable = true,
         },
         telemetry = {
            enable = false,
         },
      },
   },
}
