return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<Esc>"] = false,
                ["<C-p>"] = false,
                ["<leader>/"] = false,
              },
            },
            input = {
              keys = {
                ["<C-p>"] = false,
                ["<Esc>"] = false,
                ["<leader>/"] = false,
              },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>n",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
  },
}
