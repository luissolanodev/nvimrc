local utils = require("config.utils")

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = utils.has_nerd_fonts_support,
    },
  },
}
