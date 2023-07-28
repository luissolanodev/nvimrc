vim.opt.list = true

require('indent_blankline').setup {
    show_end_of_line = true,
    filetype_exclude = {'text', 'help', 'markdown'},
    show_current_context = true,
    context_patterns = {
        "declaration", "expression", "pattern", "primary_expression",
        "statement", "switch_body", "jsx_element", "object", "function",
        "table", "jsx_self_closing_element"
    },
    context_highlight_list = {
        'IndentBlanklineIndent1', 'IndentBlanklineIndent2',
        'IndentBlanklineIndent3', 'IndentBlanklineIndent4',
        'IndentBlanklineIndent5', 'IndentBlanklineIndent6'
    }
}
