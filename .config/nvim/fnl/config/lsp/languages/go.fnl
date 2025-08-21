(vim.lsp.enable :gopls)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:go [:gofmt]}}))
