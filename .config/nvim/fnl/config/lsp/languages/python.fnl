(vim.lsp.enable :pyright)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:python [:isort :black]}}))

