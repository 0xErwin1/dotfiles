(let [autopairs (require :nvim-autopairs)]
  (autopairs.setup {:checkTs true
                    :tsConfig {:lua [:string :source]
                               :javascript [:string :template_string]
                               :java false}
                    :disable_filetype [:TelscoprePrompt :spectre_panel]
                    :fast_wrap {:map :<M-e>
                                :chars ["{" "[" "(" "\"" "'"]
                                :offset 0
                                :endkey "$"
                                :keys :qwertyuiopzxcvbnmasdfghjkl
                                :check_comma true
                                :highlight :PmenuSel
                                :highlightGrey :LineNr}}))
