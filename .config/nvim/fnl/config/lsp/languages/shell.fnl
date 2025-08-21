(vim.lsp.enable :bashls)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:bash [:shfmt]
                                     :sh [:shfmt]
                                     :shell [:shfmt]}}))

