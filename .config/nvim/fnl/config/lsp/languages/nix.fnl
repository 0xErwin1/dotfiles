(vim.lsp.enable :nixd)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:nix [:nixfmt]}}))

