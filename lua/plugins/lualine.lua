require('lualine').setup {
   options = {
      theme = 'auto',
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      color = { gui = 'italic' }
   },
   sections = {
      lualine_a = { { 'mode' } },
      lualine_b = { { 'branch', icon = ''} },
      lualine_c = { { 'filename', file_status = true }, 'diff', {
         'diagnostics', sources = {'nvim_lsp'}
      } },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { { 'location' } },
   },
   inactive_sections = {
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
   },
   extensions = { 'nvim-tree' }
}
