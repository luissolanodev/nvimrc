require("nvim-treesitter.configs").setup {
   ensure_installed = {
      "javascript",
      "html",
      "css",
      "lua",
      "json",
      "python",
      "java",
      "cpp",
      "lua"
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
      enable = true
   }
}
