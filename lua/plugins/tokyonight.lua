require('tokyonight').setup {
    style = 'night',
    styles = {functions = {italic = true}},
    on_colors = function(colors)
        colors.bg = '#11121d'
        colors.bg_dark = '#0c0d14'
        colors.bg_float = '#0c0d14'
        colors.bg_popup = '#0c0d14'
        colors.bg_sidebar = '#0c0d14'
        colors.bg_statusline = '#0c0d14'
    end
}

vim.cmd('colorscheme tokyonight')
