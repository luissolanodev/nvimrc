require("nvim-treesitter.configs").setup {
   ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "lua",
      "json",
      "python",
      "java",
      "cpp",
      "lua",
      "toml"
   },
   playgroud = {
      enable = true
   },
   indent = {
      enable = true
   },
   highlight = {
      enable = true
   },
   autotag = {
      enable = true
   },
   rainbow = {
      enable = true,
      extended_mode = true
   }
}
