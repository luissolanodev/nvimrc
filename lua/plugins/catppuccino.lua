local catppuccino = require('catppuccino')
local variant = 'neon_latte'
local cp_api = require('catppuccino.api.colors')
local err, colors = cp_api.get_colors(variant)

if err.status then
   catppuccino.remap({}, {
      VertSplit = { fg = colors.magenta },
      NvimTreeVertSplit = { fg = colors.magenta },
      NvimTreeRootFolder = { fg = colors.blue, style = 'bold,italic'},
      TSTagAttribute = { style = 'italic' }
   })
end

catppuccino.setup {
   colorscheme = variant,
   term_colors = true,
   styles = {
      comments = 'italic',
      functions = 'italic',
      keywords = 'bold,italic',
      strings = 'NONE',
      variables = 'NONE',
   },
   integrations = {
      cmp = true,
      treesitter = true,
      native_lsp = {
         enabled = true,
         virtual_text = {
            errors = 'italic',
            hints = 'italic',
            warnings = 'italic',
            information = 'italic',
         },
         underlines = {
            errors = 'undercurl',
            hints = 'undercurl',
            warnings = 'undercurl',
            information = 'undercurl',
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
      indent_blankline = {
         enabled = true,
         colored_indent_levels = true
      },
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
vim.cmd('colorscheme catppuccino')
