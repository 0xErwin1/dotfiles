(let [render (require :render-markdown)]
  (render.setup {:latex {:enable false}
                 :custom {:started {:raw "[>]"
                                    :rendered ""
                                    :highlight :RenderMarkdownTableHead}
                          :deleted {:raw "[~]"
                                    :rendered ""
                                    :highlight :RenderMarkdownError}
                          :waiting {:raw "[@]"
                                    :rendered "󰥔 "
                                    :highlight :RenderMarkdownInfo}}}))

(vim.lsp.config :ltex
                {:cmd_env {:_JAVA_OPTIONS (.. (or vim.env._JAVA_OPTIONS "")
                                              " -Djdk.xml.totalEntitySizeLimit=0"
                                              " --enable-native-access=ALL-UNNAMED"
                                              " --add-opens=java.base/java.lang=ALL-UNNAMED"
                                              " --add-opens=java.base/java.util=ALL-UNNAMED")}
                 :filetypes [:latex
                             :tex
                             :bib
                             :markdown
                             :gitcommit
                             :text
                             :org
                             :norg]
                 :settings {:latex {:enabled [:latex
                                              :tex
                                              :bib
                                              :markdown
                                              :gitcommit
                                              :text
                                              :org
                                              :norg]
                                    :language :auto
                                    :dictionary {:es [":/home/iperez/.config/nvim/dict/es"]}}}})

(vim.lsp.enable :ltex)

