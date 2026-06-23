local utils = require("config.utils")

local function set_indent_hls()
  local colors = require("tokyonight.colors").setup({ style = "night" })

  local function blend(fg, bg, alpha)
    local parse = function(hex)
      hex = hex:gsub("#", "")
      return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
    end
    local fr, fg_, fb = parse(fg)
    local br, bg_, bb = parse(bg)
    return string.format(
      "#%02x%02x%02x",
      math.floor(fr * alpha + br * (1 - alpha)),
      math.floor(fg_ * alpha + bg_ * (1 - alpha)),
      math.floor(fb * alpha + bb * (1 - alpha))
    )
  end

  local palette = { colors.blue, colors.green1, colors.yellow, colors.orange, colors.magenta, colors.cyan }
  local dim_alpha = 0.25

  for i, color in ipairs(palette) do
    vim.api.nvim_set_hl(0, "SnacksIndentScope" .. i, { fg = color })
    vim.api.nvim_set_hl(0, "SnacksIndent" .. i, { fg = blend(color, colors.bg_dark, dim_alpha) })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_indent_hls,
})
set_indent_hls()

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local full = {}
    for i = 1, 6 do
      table.insert(full, "SnacksIndentScope" .. i)
    end

    opts.indent = {
      enabled = true,
      indent = {
        char = "│",
        hl = "SnacksIndent",
      },
      scope = {
        enabled = true,
        char = "│",
        hl = full,
      },
    }

    opts.picker = opts.picker or {}
    opts.picker.icons = {
      files = {
        enabled = utils.has_nerd_fonts_support,
      },
    }
    opts.picker.sources = {
      explorer = {
        hidden = true,
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
    }
  end,
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
