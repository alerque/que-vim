require("conform").setup({
   format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
   },
   formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format", "ruff_organize_imports" },
      rust = {
         "rustfmt",
         lsp_format = "fallback",
      },
   },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
