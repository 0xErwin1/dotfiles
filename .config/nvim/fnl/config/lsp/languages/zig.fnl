(vim.lsp.enable :zls)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:zig [:zigfmt]}}))

