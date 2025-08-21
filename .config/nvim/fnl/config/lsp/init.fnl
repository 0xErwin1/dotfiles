(let [fidget (require :fidget)]
  (fidget.setup))

(let [lsp_signature (require :lsp_signature)]
  (lsp_signature.setup {:bind true
                        :max_height 10
                        :max_width 70
                        :noice true
                        :wrap true
                        :floating_window true}))

(vim.api.nvim_create_autocmd :LspAttach
                             {:callback (fn [args]
                                          (local client
                                                 (assert (vim.lsp.get_client_by_id args.data.client_id)))
                                          (when (client:supports_method :textDocument/inlayHint)
                                            (vim.lsp.inlay_hint.enable true))
                                          (when (client:supports_method :textDocument/completion)
                                            (vim.lsp.completion.enable true
                                                                       client.id
                                                                       args.buf
                                                                       {:autotrigger false}))
                                          (when (client:supports_method :textDocument/documentSymbol)
                                            (let [navic (require :nvim-navic)]
                                              (navic.attach client args.buf))))
                              :group (vim.api.nvim_create_augroup :lsp {})})

(vim.keymap.set [:n :v] :<leader>ca "<cmd>FzfLua lsp_code_actions<CR>"
                {:desc "Code actions" :silent true})

(vim.keymap.set :n :<leader>cd "<cmd>lua vim.diagnostic.open_float()<CR>"
                {:desc "Line diagnostics"})

(vim.keymap.set :n :<leader>cr "<cmd>lua vim.lsp.buf.rename()<CR>"
                {:desc :Rename})

(vim.keymap.set :n :<leader>dD "<cmd>lua vim.diagnostic.goto_next()<CR>"
                {:desc "Next diagnostic"})

(vim.keymap.set :n :<leader>dE
                "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>"
                {:desc "Next Error"})

(vim.keymap.set :n :<leader>dW
                "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>"
                {:desc "Next Warning"})

(vim.keymap.set :n :<leader>dd "<cmd>lua vim.diagnostic.goto_prev()<CR>"
                {:desc "Previous Diagnostic"})

(vim.keymap.set :n :<leader>de
                "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>"
                {:desc "Previous Error"})

(vim.keymap.set :n :<leader>dw
                "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>"
                {:desc "Previous Warning"})

(require :config.lsp.mason)
(require :config.lsp.cmp)
(require :config.lsp.conform)
(require :config.lsp.languages)
