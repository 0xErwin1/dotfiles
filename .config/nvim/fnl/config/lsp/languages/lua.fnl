(vim.lsp.enable :lua_ls
                {:settings {:Lua {:completion {:callSnippet :Replace}
                                  :telemetry {:enable false}
                                  :runtime {:version :LuaJIT}
                                  :diagnostics {:globals [:vim]}}}})

(vim.lsp.enable :fennel_ls)
