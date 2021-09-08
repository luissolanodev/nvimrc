require('indent_blankline').setup {
   char = '│',
   filetype_exclude = {'text', 'help', 'markdown', 'dashboard'},
   show_trailing_blankline_indent = false,
   char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6'
   }
}
-- Consistency with indent guides, only show tabs if we also shown spaces
-- with this plugin.
vim.opt.listchars.tab = '│'
