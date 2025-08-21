(vim.lsp.config :elixirls {:cmd [:elixir-ls]})

(vim.lsp.enable :elixirls)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:elixir [:mix-format]
                                     :eelixir [:mix-format]
                                     :heex [:mix-format]}}))

