require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "javascript", "typescript", "tsx", "html", "css", "lua", "json",
        "python", "java", "cpp", "toml", "markdown"
    },
    highlight = {enable = true},
    indent = {enable = false},
}
