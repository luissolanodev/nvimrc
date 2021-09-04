require("lualine").setup {
   options = {
      theme = "catppuccino",
      section_separators = {"", ""},
      component_separators = {"", ""},
      disabled_filetypes = {},
      color = {gui = "italic"}
   },
   sections = {
      lualine_a = { {"mode", color = { gui = "bold" }} },
      lualine_b = { {"branch", icon = ""} },
      lualine_c = { {"filename", file_status = true }, "diff", {"diagnostics", sources = {"nvim_lsp"}} },
      lualine_x = { "encoding", "fileformat", "filetype"},
      lualine_y = { "progress" },
      lualine_z = { {"location", color = { gui = "bold"}} },
   },
   inactive_sections = {
      lualine_c = { "filename" },
      lualine_x = { "location" },
   },
   extensions = { "nvim-tree" }
}
