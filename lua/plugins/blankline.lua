local g = vim.g

g.indent_blankline_char = "│"
g.indent_blankline_filetype_exclude = {"text", "help", "markdown", "dashboard"}
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_use_treesitter = true
g.indent_blankline_char_highlight_list = {
   "Keyword",
   "Label",
   "Delimiter",
   "Function",
   "Define",
   "Number",
   "Tag"
}
-- Consistency with indent guides, only show tabs if we also shown spaces
-- with this plugin
vim.opt.listchars = vim.opt.listchars + "tab:\\│"
