local utils = require("config.utils")

return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    local hl = require("tokyonight.colors").setup({ style = "night" })

    opts.options = vim.tbl_extend("force", opts.options or {}, {
      separator_style = "slant",
      indicator = { style = "none" },
      show_buffer_icons = utils.has_nerd_fonts_support,
      show_buffer_close_icons = true,
      show_close_icon = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = { error = " ", warning = " ", info = " " }
        local result = {}
        for level, icon in pairs(icons) do
          if diag[level] and diag[level] > 0 then
            table.insert(result, icon .. diag[level])
          end
        end
        return #result > 0 and table.concat(result, " ") or ""
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "center",
        },
      },
    })

    opts.highlights = {
      fill = { bg = hl.bg_dark },
      background = { fg = hl.comment, bg = hl.bg_dark, italic = true },
      tab = { fg = hl.comment, bg = hl.bg_dark },
      tab_selected = { fg = hl.blue, bg = hl.bg_highlight, bold = true },
      buffer_visible = { fg = hl.comment, bg = hl.bg_dark },
      buffer_selected = { fg = hl.fg, bg = hl.bg_highlight, bold = true, italic = false },
      separator = { fg = hl.bg_dark, bg = hl.bg_dark },
      separator_selected = { fg = hl.bg_dark, bg = hl.bg_highlight },
      separator_visible = { fg = hl.bg_dark, bg = hl.bg_dark },
      indicator_selected = { fg = hl.blue, bg = hl.bg_highlight },
      modified = { fg = hl.yellow, bg = hl.bg_dark },
      modified_selected = { fg = hl.yellow, bg = hl.bg_highlight, bold = true },
      close_button = { fg = hl.comment, bg = hl.bg_dark },
      close_button_selected = { fg = hl.red, bg = hl.bg_highlight },
      diagnostic = { fg = hl.comment, bg = hl.bg_dark },
      diagnostic_selected = { fg = hl.fg, bg = hl.bg_highlight, bold = true },
      error = { fg = hl.red, bg = hl.bg_dark },
      error_selected = { fg = hl.red, bg = hl.bg_highlight, bold = true },
      warning = { fg = hl.yellow, bg = hl.bg_dark },
      warning_selected = { fg = hl.yellow, bg = hl.bg_highlight, bold = true },
      info = { fg = hl.blue, bg = hl.bg_dark },
      info_selected = { fg = hl.blue, bg = hl.bg_highlight, bold = true },
    }
  end,
}
