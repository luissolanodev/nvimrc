require('catppuccin').setup {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {
        -- :h background
        light = 'latte',
        dark = 'mocha'
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {enabled = false, shade = 'dark', percentage = 0.15},
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = {'italic'},
        conditionals = {'italic,bold'},
        loops = {'italic,bold'},
        functions = {'italic,bold'},
        keywords = {'italic,bold'},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {'italic,bold'},
        properties = {},
        types = {'italic,bold'},
        operators = {}
    },
    color_overrides = {
        mocha = {base = "#1b1b1b", mantle = "#1b1b1b", crust = "#1b1b1b"}
    },
    highlight_overrides = {
        mocha = function(C)
            return {
                TabLineSel = {bg = C.pink},
                NvimTreeNormal = {bg = C.none},
                CmpBorder = {fg = C.surface2},
                Pmenu = {bg = C.none},
                NormalFloat = {bg = C.none},
                TelescopeBorder = {link = "FloatBorder"}
            }
        end
    },
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        indent_blankline = {enabled = true, colored_indent_levels = true},
        navic = {enabled = true},
        native_lsp = {
            enabled = true,
            underlines = {
                errors = {"undercurl"},
                hints = {"undercurl "},
                warnings = {"undercurl"},
                information = {"undercurl"}
            }
        }
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    }
}

-- setup must be called before loading
-- vim.cmd.colorscheme('catppuccin')
