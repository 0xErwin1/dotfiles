(let [ayu (require :ayu)]
  (ayu.setup {:mirage false}))

(let [tokyodark (require :tokyodark)]
  (tokyodark.setup {:gamma 1
                    :styles {:comments {:italic true}
                             :functions {:bold true :italic true}
                             :identifiers {:italic true}
                             :keywords {:bold true :italic true}
                             :variables {:bold true}}
                    :transparent_background true}))

(vim.cmd.colorscheme :ayu)

(let [nvim-icons (require :nvim-web-devicons)]
  (nvim-icons.setup {:color_icons true
                     :override_by_extension {:ign {:icon "󰈸"
                                                   :color "#702963"
                                                   :name :Ignis}}}))
