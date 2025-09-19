(local kinds {:Supermaven " "
              :Copilot " "
              :Array "󰕤 "
              :Boolean " "
              :Class " "
              :Color " "
              :Constant " "
              :Constructor " "
              :Enum " "
              :EnumMember " "
              :Event "󱐋"
              :Field " "
              :File " "
              :Folder " "
              :Function "󰘧"
              :Interface " "
              :Key " "
              :Keyword " "
              :Method " "
              :Module " "
              :Namespace " "
              :Null "󰟢"
              :Number " "
              :Object " "
              :Operator " "
              :Package " "
              :Property "󱕴"
              :Reference " "
              :Snippet " "
              :String "󰅳 "
              :Struct " "
              :Text "󰦪"
              :TypeParameter "󰡱 "
              :Unit " "
              :Value " "
              :Variable "󰫧 "
              :Macro "󱃖 "})

(fn _G.cmp-format [entry vim-item]
  (let [kind (((. (require :lspkind) :cmp_format) {:maxwidth 50
                                                   :mode :symbol_text
                                                   :symbol_map kinds}) entry
                                                                                                                                                                                                             vim-item)
        strings (vim.split kind.kind "%s" {:trimempty true})]
    (set kind.kind (.. " " (or (. strings 1) "") " "))
    (set kind.menu (.. "⌈" (or (. strings 2) "") "⌋"))
    kind))

(let [copilot (require :copilot_cmp)]
  (copilot.setup))

(let [cmp (require :cmp)]
  (cmp.setup {:confirm_opts {:behavior cmp.ConfirmBehavior.Replace
                             :select false}
              :experimental {:ghost_text true :native_menu false}
              :formatting {:expandable_indicator false
                           :fields [:abbr :kind :menu]
                           :format _G.cmp-format}
              :preselect cmp.PreselectMode.None
              :mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete)
                                                   :<C-d> (cmp.mapping.scroll_docs (- 4))
                                                   :<C-e> (cmp.mapping.abort)
                                                   :<C-f> (cmp.mapping.scroll_docs 4)
                                                   :<C-j> (cmp.mapping.select_next_item)
                                                   :<C-k> (cmp.mapping.select_prev_item)
                                                   :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                                               :select false})
                                                   :<S-Tab> (cmp.mapping (fn [fallback]
                                                                           (if (cmp.visible)
                                                                               (cmp.select_prev_item {:behavior cmp.SelectBehavior.Select})
                                                                               (fallback))))
                                                   :<Tab> (cmp.mapping (fn [fallback]
                                                                         (if (cmp.visible)
                                                                             (cmp.select_next_item {:behavior cmp.SelectBehavior.Select})
                                                                             (fallback))))})
              :native {:border ["╭"
                                "─"
                                "╮"
                                "│"
                                "╯"
                                "─"
                                "╰"
                                "│"]}
              :sorting {:comparators [cmp.config.compare.offset
                                      cmp.config.compare.exact
                                      cmp.config.compare.score
                                      cmp.config.compare.recently_used
                                      cmp.config.compare.locality
                                      cmp.config.compare.kind
                                      cmp.config.compare.sort_text
                                      cmp.config.compare.length
                                      cmp.config.compare.order]
                        :priority_weight 10}
              :sources [{:name :nvim_lsp}
                        {:group_index 2 :name :path}
                        {:group_index 2 :name :copilot}
                        {:name :nvim_lua}
                        {:name :buffer}
                        {:name :async_path}
                        {:name :treesitter}]
              :view {:entries :custom}
              :window {:completion (cmp.config.window.bordered)
                       :documentation (cmp.config.window.bordered)}})
  (cmp.setup.cmdline ["/" "?"]
                     {:mapping (cmp.mapping.preset.cmdline)
                      :sources [{:name :buffer}]})
  (cmp.setup.cmdline ":"
                     {:mapping (cmp.mapping.preset.cmdline)
                      :matching {:disallow_symbol_nonprefix_matching false}
                      :sources (cmp.config.sources [{:name :path}]
                                                   [{:name :cmdline}])}))

