vim.opt.list = true
vim.opt.listchars = {
   tab = "> ",
   eol = "$"
}

require('indent_blankline').setup {
   show_end_of_line = true,
   filetype_exclude = {'text', 'help', 'markdown', 'dashboard'},
   show_current_context = true,
   context_patterns = {
      "declaration", "expression", "pattern", "primary_expression",
      "statement", "switch_body", "jsx_element", "object", "function", "table"
   },
   -- char_highlight_list = {
      -- 'IndentBlanklineIndent1',
      -- 'IndentBlanklineIndent2',
      -- 'IndentBlanklineIndent3',
      -- 'IndentBlanklineIndent4',
      -- 'IndentBlanklineIndent5',
      -- 'IndentBlanklineIndent6'
   -- },
   context_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6'
   }
}
