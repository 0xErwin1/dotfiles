(vim.lsp.config :ts_ls
                { :filetypes [:javascript
                             :javascriptreact
                             :javascript.jsx
                             :typescript
                             :typescriptreact
                             :typescript.tsx]
                 :root_dir (fn [bufnr on-dir]
                             (local project-root-markers
                                    [:package-lock.json
                                     :yarn.lock
                                     :pnpm-lock.yaml
                                     :bun.lockb
                                     :bun.lock])
                             (local project-root
                                    (vim.fs.root bufnr project-root-markers))
                             (when (not project-root) (lua "return nil"))
                             (local ts-config-files
                                    [:tsconfig.json :jsconfig.json])
                             (local is-buffer-using-typescript
                                    (. (vim.fs.find ts-config-files
                                                    {:limit 1
                                                     :path (vim.api.nvim_buf_get_name bufnr)
                                                     :stop (vim.fs.dirname project-root)
                                                     :type :file
                                                     :upward true})
                                       1))
                             (when (not is-buffer-using-typescript)
                               (lua "return nil"))
                             (on-dir project-root))})

(vim.lsp.enable :tsgo {})

(vim.lsp.enable :biome)
(vim.lsp.enable :astro)
