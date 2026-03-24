vim.g.rustaceanvim = {
  tools = {
     enable_clippy = true,
     enable_nextest = false,
     float_win_config = {
        open_split = "vertical",
     },
  },
  server = {
    on_attach = function(client, bufnr)
    end,
    default_settings = {
      ['rust-analyzer'] = {
      },
    },
  },
  dap = {
  },
}
