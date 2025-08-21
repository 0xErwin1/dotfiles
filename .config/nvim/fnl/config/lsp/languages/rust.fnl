(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:rust [:rustfmt] :toml [:rustfmt]}}))

