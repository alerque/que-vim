require("minuet").setup({
   virtualtext = {
      auto_trigger_ft = { "rust" },
      keymap = {
         accept = "<A-A>",
         accept_line = "<A-a>",
         accept_n_lines = "<A-z>",
         prev = "<A-[>",
         next = "<A-]>",
         dismiss = "<A-e>",
      },
   },
   provider = "openai_fim_compatible",
   n_completions = 3,
   context_window = 1024,
   provider_options = {
      openai_fim_compatible = {
         api_key = "USER",
         name = "Ollama",
         end_point = "http://localhost:11434/v1/completions",
         -- model = "codellama:7b-code",
         -- model = "qwen2.5-coder:7b",
         model = "qwen2.5-coder:0.5b",
         optional = {
            max_tokens = 56,
            top_p = 0.9,
         },
      },
   },
})
