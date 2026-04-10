return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  opts = {
    max_lines = 3,        -- max lines the context window can take up
    min_window_height = 20, -- don't show context in very short windows
    multiline_threshold = 1, -- collapse multiline nodes into a single line
    mode = "cursor",      -- "cursor" = context of current cursor position
    separator = "─",      -- subtle line separating context from code
  },
  config = function(_, opts)
    local colors = require("tokyonight.colors").setup({ style = "night" })
    -- match the separator and context bg to your theme
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.bg_highlight })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = colors.comment, bg = colors.bg_highlight })
    vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { fg = colors.comment })
    require("treesitter-context").setup(opts)
  end,
}
