return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          theme = "ivy",
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
