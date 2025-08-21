(vim.lsp.enable :clangd)

(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:nasm [:asmfmt]
                                     :asm [:asmfmt]
                                     :c [:clang-format]
                                     :cpp [:clang-format]
                                     :cmake [:cmake-format]
                                     :make [:cmake-format]}}))
