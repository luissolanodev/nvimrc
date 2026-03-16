local utils = require("config.utils")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      pickers = {
        find_files = {
          theme = "ivy",
          disable_devicons = not utils.has_nerd_fonts_support,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ cwd = LazyVim.root() })
        end,
        desc = "Find Files (Root Dir)",
      },
    },
  },
}
