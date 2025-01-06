require("tokyonight").setup({
    style = "night",
    styles = {
        functions = { italic = false },
        comments = { italic = false },
        keywords = { italic = false },
        variables = { italic = false }
    },
})

vim.cmd("colorscheme tokyonight")
