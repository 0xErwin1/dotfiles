(let [conform (require :conform)]
  (conform.setup {:formatters_by_ft {:json [:prettierd :jq]
                                     :markdown [:prettierd]
                                     :ignis [:squeeze_blanks
                                             :trim_whitespace
                                             :trim_newlines]
                                     :_ [:squeeze_blanks
                                         :trim_whitespace
                                         :trim_newlines]}}))

(let [wk (require :which-key)]
  (wk.add [{1 :<leader>cf
            2 "<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<CR>"
            :desc "Format code"
            :mode :n
            :group :Code}]))

