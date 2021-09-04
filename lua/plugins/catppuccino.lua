local catppuccino = require('catppuccino')

catppuccino.setup {
   colorscheme = 'neon_latte',
   term_colors = true,
   styles = {
      comments = "italic",
      functions = "italic",
      keywords = "italic",
      strings = "italic",
      variables = "NONE",
   },
   integrations = {
      treesitter = true,
      native_lsp = {
         enabled = true,
         styles = {
            errors = "italic",
            hints = "italic",
            warnings = "italic",
            information = "italic"
         }
      },
      lsp_trouble = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
         enabled = true,
         show_root = true,
      },
      which_key = true,
      indent_blankline = true,
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = true
   }
}

catppuccino.load()
