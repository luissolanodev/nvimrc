local navic = require('nvim-navic')

require('lualine').setup {
    options = {
        theme = 'auto',
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''}
    },
    sections = {
        lualine_a = {{'mode'}},
        lualine_b = {{'branch', icon = ''}},
        lualine_c = {
            {'filename', file_status = true}, 'diff',
            {'diagnostics', sources = {'nvim_lsp'}},
            {navic.get_location, cond = navic.is_available}
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {{'location'}}
    },
    inactive_sections = {lualine_c = {'filename'}, lualine_x = {'location'}},
    extensions = {'nvim-tree'}
}
