return {
   filetypes = { "markdown", "pandoc" },
   capabilities = {
      workspace = {
         didChangeWatchedFiles = {
            dynamicRegistration = true,
         },
      },
   },
}
