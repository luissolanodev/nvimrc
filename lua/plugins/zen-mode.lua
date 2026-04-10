return {
  {
    "folke/twilight.nvim",
    opts = {
      dimming = { alpha = 0.4 },
      context = 15, -- lines around cursor to keep lit
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        width = 0.65, -- 65% of screen width
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },
}
