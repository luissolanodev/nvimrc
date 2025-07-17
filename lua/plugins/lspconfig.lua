return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      intelephense = {
        root_dir = require("lspconfig").util.root_pattern("index.php", ".git"),
      },
    },
  },
}
