local autopairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

autopairs.setup()

autopairs.add_rules {
   Rule("%(.*%)%s*%=>$",
      " {}",
      { "typescript", "typescriptreact", "javascript", "javascriptreact" }
   ):use_regex(true):set_end_pair_length(1),
}
