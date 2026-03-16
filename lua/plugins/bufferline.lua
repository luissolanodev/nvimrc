local utils = require("config.utils")

return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      show_buffer_icons = utils.has_nerd_fonts_support,
      separator_style = "slant",
    },
  },
}
