local g = vim.g
g.indent_blankline_char = "│"
-- g.indent_blankline_char_highlight_list = {"Keyword", "Label", "Delimiter", "Function", "Define", "Number", "Tag"}
g.indent_blankline_filetype_exclude = {"text", "help", "markdown", "dashboard"}
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_use_treesitter = true
vim.cmd("set list lcs=tab:│\\") -- show character for indentation levels with tabs
